import wollok.game.*
import personaje.*
import elementos.*
import paredes.*


class Nivel {
	const ganaste = new Elemento(image = "ganaste.jpg")
	const perdiste = new Elemento(image = "perdiste.jpg")
	const controles = new Elemento(image = "controles.jpg")
	const inicio = new Elemento(image = "inicio.jpg")
	const pausa = new Elemento(image = "pausa.jpg")
	const visuales = [inicio, controles, ganaste, perdiste, pausa]
	const posicionParedes = []
	const posicionesRelojP = []
	const posicionesRelojN = []
	const posicionesPuntosP = []
	const posicionesPuntosN = []
	const inicioPersonaje
	const inicioPuerta

	const fantasma1 = new Enemigo(position = game.at(11, 8))
	const fantasma2 = new Enemigo(position = game.at(4, 1))
	const fantasma3 = new Enemigo(position = game.at(8, 11))
	const enemigos = [fantasma1, fantasma2, fantasma3]

	method iniciar() {
        
		self.generarParedes()

		puerta.position(inicioPuerta)
		puerta.aparecer()

		personaje.position(inicioPersonaje)
        personaje.iniciar()

		game.onCollideDo(personaje, {algo => algo.teAgarraron()})
		reloj.iniciar() //que inicie cuando desaparece el inicio

		self.generarLlave()
		self.generarPuntos()

		self.configurarTeclas()
		self.teclaEspecial()
		
		self.terminarNivel()

    }	

	method teclaEspecial() {
		keyboard.f().onPressDo({
			self.eliminarVisuales(visuales) // Limpia los visuales actuales del nivel1
			game.clear() // Borra el estado del juego actual
			nivel2.iniciar() // Inicia el siguiente nivel (nivel2)
		})
	}

	method configurarTeclas() {
		keyboard.right().onPressDo({
			if(not self.hayVisual(visuales))
				personaje.moveteADerecha(posicionParedes) 
		})
		keyboard.left().onPressDo({
			if(not self.hayVisual(visuales))
				personaje.moveteAIzquierda(posicionParedes)
		})
		keyboard.up().onPressDo({
			if(not self.hayVisual(visuales))
				personaje.moveteArriba(posicionParedes)
		})
		keyboard.down().onPressDo({
			if(not self.hayVisual(visuales))
				personaje.moveteAbajo(posicionParedes)
		})

		keyboard.enter().onPressDo({
			self.eliminarVisuales(visuales)
			self.iniciarFantasmas() //tira mensaje por consola
			reloj.iniciar()
		})

		keyboard.p().onPressDo({
				self.eliminarVisuales(visuales)
				reloj.pararTiempo() 
				reloj.desaparecer()
				self.eliminarEnemigos()
				pausa.aparecer() 
		})

		keyboard.c().onPressDo({
			self.eliminarVisuales(visuales)
			reloj.pararTiempo()
			reloj.desaparecer()
			self.eliminarEnemigos()
			controles.aparecer()
		})

		keyboard.r().onPressDo({
			self.reiniciar()
		})

		keyboard.i().onPressDo({
			self.eliminarVisuales(visuales)
			self.reiniciar()
			reloj.pararTiempo()
			reloj.desaparecer()
			self.eliminarEnemigos()
			inicio.aparecer()
		})
	}

	method generarParedes()
	method generarLlave()
	method generarPuntos() {
		self.generarPuntosRelojP()
		self.generarPuntosRelojN()
		self.generarPuntosP()
		self.generarPuntosN()
	}
	method generarPuntosRelojP()
	method generarPuntosRelojN()
	method generarPuntosP()
	method generarPuntosN()
	method terminarNivel() {}
	method eliminarVisuales(lista) {
		const activos = lista.filter({v => game.hasVisual(v)})
		if(self.hayVisual(lista)) 
				activos.forEach({v => game.removeVisual(v)})
	}
	method hayVisual(lista) = lista.any({v => game.hasVisual(v)})

	method dibujar(dibujo) {
		game.addVisual(dibujo)
	}

	method puedeGanar() = personaje.puedePasar() && personaje.position() == puerta.position() && reloj.hayTiempo()

	method noGano() = not reloj.hayTiempo()

	method limpiarParedes() {
		posicionParedes.removeAll(posicionParedes)
	}

	method eliminarEnemigos() {
		enemigos.forEach({e => e.desaparecer()})
		enemigos.forEach({e => e.cortarParpadeo()})
	}

	method iniciarFantasmas() {}

	method reiniciar() {
		game.clear()
		personaje.position(inicioPersonaje)
		personaje.reiniciarPuntos()
		personaje.reiniciarLlaves()
		reloj.reiniciarTiempo()
		self.limpiarParedes()
		personaje.reiniciarVidas()
		self.iniciar()
	}
}


object nivel1 inherits Nivel(inicioPersonaje = game.at(0, 11), inicioPuerta = game.at(14, 1)){

	
	override method generarParedes() {
		(0..14).forEach({n => posicionParedes.add(new Position(x = n, y = 0))}) // Línea superior
		(0..14).forEach({n => posicionParedes.add(new Position(x = n, y = 12))}) // Línea inferior
		(1..10).forEach({n => posicionParedes.add(new Position(x = 0, y = n))})  // Lateral izquierdo
		(2..12).forEach({n => posicionParedes.add(new Position(x = 14, y = n))}) // Lateral derecho
   
		(3..9).forEach({n => posicionParedes.add(new Position(x = n, y = 2))})
		
		(7..12).forEach({n => posicionParedes.add(new Position(x = n, y = 6))})
		(2..6).forEach({n => posicionParedes.add(new Position(x = n, y = 8))})
		(10..12).forEach({n => posicionParedes.add(new Position(x = n, y = 10))})
		
		(3..7).forEach({n => posicionParedes.add(new Position(x = 2, y = n))})
		(5..10).forEach({n => posicionParedes.add(new Position(x = 6, y = n))})
		(4..8).forEach({n => posicionParedes.add(new Position(x = 10, y = n))})
		(8..11).forEach({n => posicionParedes.add(new Position(x = 12, y = n))})
		
		posicionParedes.addAll([
			new Position(x = 5, y = 3), new Position(x = 8, y = 5),
			new Position(x = 4, y = 7), new Position(x = 10, y = 9)
		])
		
		posicionParedes.forEach({p => self.dibujar(new Paredes(position = p))})
	}
	
	override method generarLlave() {
		const llaves = [new Position(x = 1, y = 1), new Position(x = 11, y = 11), 
		new Position(x = 5, y = 4)].forEach({p => self.dibujar(new Llave(position = p))})
	}


	override method generarPuntosRelojP() {
		[4, 7].forEach({n => posicionesRelojP.add(new Position(x = 1, y = n))})
		[5, 9].forEach({n => posicionesRelojP.add(new Position(x = 5, y = n))})
		[1, 11].forEach({n => posicionesRelojP.add(new Position(x = 7, y = n))})
		[6, 10].forEach({n => posicionesRelojP.add(new Position(x = 13, y = n))})
		posicionesRelojP.addAll([new Position(x = 11, y = 7), new Position(x = 9, y = 4)])

		posicionesRelojP.forEach({posicionesRelojP => self.dibujar(new PuntosRelojPos(position = posicionesRelojP))})
	}

	override method generarPuntosRelojN() {
		posicionesRelojN.addAll([new Position(x = 3, y = 1), new Position(x = 5, y = 11),
		new Position(x = 11, y = 5), new Position(x = 3, y = 9),
		new Position(x = 7, y = 8), new Position(x = 9, y = 10)])

		posicionesRelojN.forEach({posicionesRelojN => self.dibujar(new PuntosRelojNeg(position = posicionesRelojN))})
	}

	override method generarPuntosP() {
		[3, 10].forEach({n => posicionesPuntosP.add(new Position(x = 1, y = n))})
		[3, 11].forEach({n => posicionesPuntosP.add(new Position(x = 3, y = n))})
		[3, 5].forEach({n => posicionesPuntosP.add(new Position(x = 7, y = n))})
		[9, 11].forEach({n => posicionesPuntosP.add(new Position(x = 9, y = n))})
		[1, 4, 8].forEach({n => posicionesPuntosP.add(new Position(x = 11, y = n))})
		[3, 5].forEach({n => posicionesPuntosP.add(new Position(x = 13, y = n))})

		posicionesPuntosP.addAll([new Position(x = 2, y = 10), new Position(x = 5, y = 10)])

		posicionesPuntosP.forEach({posicionesPuntosP => self.dibujar(new PuntosPersonajePos(position = posicionesPuntosP))})
	}

	override method generarPuntosN() {
		posicionesPuntosN.addAll([new Position(x = 2, y = 2), new Position(x = 3, y = 6), new Position(x = 13, y = 8)])
		[8, 9].forEach({n => posicionesPuntosN.add(new Position(x = 1, y = n))})
		[3, 11].forEach({n => posicionesPuntosN.add(new Position(x = 6, y = n))})
		[2, 11].forEach({n => posicionesPuntosN.add(new Position(x = 10, y = n))})
		posicionesPuntosN.forEach({posicionesPuntosN => self.dibujar(new PuntosPersonajeNeg(position = posicionesPuntosN))})
	}

	override method terminarNivel() {
		if(self.puedeGanar()) {
			game.clear() 
			nivel2.iniciar() 
			personaje.cambiarNivel()
		}
	}
}


object nivel2 inherits Nivel(inicioPersonaje = game.at(0, 11), inicioPuerta = game.at(14, 1)){

    override method iniciar() {
        
		self.iniciarFantasmas()

		reloj.reiniciarTiempo()

		personaje.reiniciarPuntos()
		personaje.reiniciarLlaves()
		
		super()
    }
	
/*	override method teclaEspecial() {
		// Control para finalizar el juego
		keyboard.f().onPressDo({
			game.clear() // Limpiar el estado del juego
			self.eliminarVisuales(visuales)
			reloj.pararTiempo() // Detener el reloj
			reloj.desaparecer()

			// Mostrar mensaje final
			if(self.puedeGanar()) {
				ganaste.aparecer() //no permite reiniciar ni nada, se queda ahi
			} else {
				perdiste.aparecer() //no permite reiniciar ni nada, se queda ahi
			}
		})
	}*/

	override method generarParedes() {
		(0.. 14).forEach({n => posicionParedes.add(new Position(x = n, y = 0))})
		(1.. 10).forEach({n => posicionParedes.add(new Position(x = 0, y = n))})
		(0 .. 14).forEach({n => posicionParedes.add(new Position(x = n, y = 12))})
		(2 .. 12).forEach({n => posicionParedes.add(new Position(x = 14, y = n))})

		(2.. 8).forEach({n => posicionParedes.add(new Position(x = n, y = 3))})
		[10, 11].forEach({n => posicionParedes.add(new Position(x = n, y = 3))})
		[1, 2].forEach({n => posicionParedes.add(new Position(x = n, y = 5))})
		(6.. 10).forEach({n => posicionParedes.add(new Position(x = n, y = 5))})
		(2.. 8).forEach({n => posicionParedes.add(new Position(x = n, y = 7))})
		[12, 13].forEach({n => posicionParedes.add(new Position(x = n, y = 7))})
		(11.. 13).forEach({n => posicionParedes.add(new Position(x = n, y = 9))})

		(9.. 11).forEach({n => posicionParedes.add(new Position(x = 2, y = n))})
		(2.. 10).forEach({n => posicionParedes.add(new Position(x = 4, y = n))})
		(9.. 11).forEach({n => posicionParedes.add(new Position(x = 6, y = n))})
		[0, 1].forEach({n => posicionParedes.add(new Position(x = 6, y = n))})
		(8.. 10).forEach({n => posicionParedes.add(new Position(x = 8, y = n))})
		(6.. 10).forEach({n => posicionParedes.add(new Position(x = 10, y = n))})
		(3.. 7).forEach({n => posicionParedes.add(new Position(x = 12, y = n))})


		posicionParedes.addAll([new Position(x = 1, y = 1), new Position(x = 6, y = 1),
		new Position(x = 8, y = 2), new Position(x = 12, y = 2), new Position(x = 12, y = 11)])
		
		posicionParedes.forEach({p => self.dibujar(new Paredes(position = p))})
	}

	override method generarLlave() {

		const llaves = [new Position(x = 13, y = 8), new Position(x = 5, y = 2), 
		new Position(x = 9, y = 11)].forEach({p => self.dibujar(new Llave(position = p))})
	}

	method generarFantasmas() {
		enemigos.forEach({e => e.aparecer()})
	}

	method visibilidadFantasmas() {
		enemigos.forEach({e => e.iniciarParpadeo()})
	}

	override method iniciarFantasmas() {
		self.generarFantasmas()
		self.visibilidadFantasmas()
	}


	override method generarPuntosRelojP() {
		[4, 7].forEach({n => posicionesRelojP.add(new Position(x = 1, y = n))})
		[5, 9].forEach({n => posicionesRelojP.add(new Position(x = 5, y = n))})
		[1, 6, 11].forEach({n => posicionesRelojP.add(new Position(x = 7, y = n))})
		[6, 10].forEach({n => posicionesRelojP.add(new Position(x = 13, y = n))})

		posicionesRelojP.addAll([new Position(x = 11, y = 7), new Position(x = 9, y = 4)])

		posicionesRelojP.forEach({posicionesRelojP => self.dibujar(new PuntosRelojPos(position = posicionesRelojP))})
	}

	override method generarPuntosRelojN() {
		posicionesRelojN.addAll([new Position(x = 3, y = 1), new Position(x = 5, y = 11),
		new Position(x = 11, y = 5), new Position(x = 2, y = 6), new Position(x = 3, y = 9),
		new Position(x = 7, y = 8), new Position(x = 9, y = 10)])

		posicionesRelojN.forEach({posicionesRelojN => self.dibujar(new PuntosRelojNeg(position = posicionesRelojN))})
	}

	override method generarPuntosP() {
		[2, 3, 6, 10].forEach({n => posicionesPuntosP.add(new Position(x = 1, y = n))})
		[1, 4, 8].forEach({n => posicionesPuntosP.add(new Position(x = 2, y = n))})
		[2, 4, 11].forEach({n => posicionesPuntosP.add(new Position(x = 3, y = n))})
		[1, 4, 6, 10].forEach({n => posicionesPuntosP.add(new Position(x = 5, y = n))})
		[2, 4, 9, 10].forEach({n => posicionesPuntosP.add(new Position(x = 7, y = n))})
		[1, 2, 6, 8].forEach({n => posicionesPuntosP.add(new Position(x = 9, y = n))})
		[1, 10].forEach({n => posicionesPuntosP.add(new Position(x = 11, y = n))})
		[3, 5, 11].forEach({n => posicionesPuntosP.add(new Position(x = 13, y = n))})


		posicionesPuntosP.forEach({posicionesPuntosP => self.dibujar(new PuntosPersonajePos(position = posicionesPuntosP))})
	}


	override method generarPuntosN() {
		posicionesPuntosN.addAll([new Position(x = 2, y = 2), new Position(x = 3, y = 6),
		new Position(x = 5, y = 8), new Position(x = 12, y = 8)])

		[8, 9].forEach({n => posicionesPuntosN.add(new Position(x = 1, y = n))})
		[2, 8].forEach({n => posicionesPuntosN.add(new Position(x = 6, y = n))})
		[2, 11].forEach({n => posicionesPuntosN.add(new Position(x = 10, y = n))})

		posicionesPuntosN.forEach({posicionesPuntosN => self.dibujar(new PuntosPersonajeNeg(position = posicionesPuntosN))})
	}

	
	override method terminarNivel() {
		if(self.puedeGanar()) {
			game.clear() 
			game.addVisual(ganaste)
		}	
	}
}
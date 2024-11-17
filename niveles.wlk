import wollok.game.*
import example.*
import elementos.*
import paredes.*

object nivel1 {
	const ganaste = new Visual(image = "ganaste.jpg")
	const perdiste = new Visual(image = "perdiste.jpg")
	const controles = new Visual(image = "controles.jpg")
	const pausa = new Visual(image = "pausa.jpg")
	const inicio = new Visual(image = "inicio.jpg")
	const visuales = [inicio, pausa, controles, ganaste, perdiste]
	const paredes = []
	const posicionParedes = []
	const posicionesRelojP = []
	const posicionesRelojN = []
	const posicionesPuntosP = []
	const posicionesPuntosN = []
	const inicioPersonaje = game.at(0, 11)
	const inicioPuerta = game.at(14, 1)


    method iniciar() {
        game.height(15)
	    game.width(15)
        game.cellSize(63)

        game.boardGround("fondo.jpg")
		//fondo.configurar("fondotierra.jpg")

		self.generarParedes()

		personaje.position(inicioPersonaje)
        personaje.iniciar()

		puerta.position(inicioPuerta)
		puerta.aparecer()

		game.onCollideDo(personaje, {algo => algo.teAgarraron()})
		reloj.iniciar() //que inicie cuando desaparece el inicio

		self.generarLlave()
		self.generarPuntos()

		self.terminarJuego()
		
		keyboard.f().onPressDo({
			self.eliminarVisuales(visuales) // Limpia los visuales actuales del nivel1
			game.clear() // Borra el estado del juego actual
			nivel2.iniciar() // Inicia el siguiente nivel (nivel2)
		})


		keyboard.right().onPressDo({
			if(not self.hayVisual(visuales)) //aca o en el metodo de moverse? pq seria una pausa para personaje/s y tiempo
				personaje.moveteADerecha(self.posicionesParedes(paredes)) //??????
		})
		keyboard.left().onPressDo({
			if(not self.hayVisual(visuales))
				personaje.moveteAIzquierda(self.posicionesParedes(paredes)) //??????
		})
		keyboard.up().onPressDo({
			if(not self.hayVisual(visuales))
				personaje.moveteArriba(self.posicionesParedes(paredes)) //??????
		})
		keyboard.down().onPressDo({
			if(not self.hayVisual(visuales))
				personaje.moveteAbajo(self.posicionesParedes(paredes)) //??????
		})

		keyboard.enter().onPressDo({
			self.eliminarVisuales(visuales)
			reloj.iniciar()
		})

		keyboard.p().onPressDo({
				self.eliminarVisuales(visuales)
				reloj.pararTiempo()
				pausa.aparecer()
		})

		keyboard.c().onPressDo({
			self.eliminarVisuales(visuales)
			reloj.pararTiempo()
			controles.aparecer()
		})

		keyboard.r().onPressDo({
			self.reiniciar() //ver como reiniciar (o si no se reinicia) //como seria reiniciar para el nivel 2? se pisarian? VER
		})

		keyboard.i().onPressDo({
			self.eliminarVisuales(visuales)
			self.reiniciar()
			reloj.pararTiempo()
			inicio.aparecer()
		})

    }
	
	method eliminarVisuales(lista) {
		const activos = lista.filter({v => game.hasVisual(v)})
		if(self.hayVisual(lista)) 
				activos.forEach({v => game.removeVisual(v)})
	}

	method hayVisual(lista) = lista.any({v => game.hasVisual(v)})

	method posicionesParedes(listaParedes) = listaParedes.map({p => p.position()})

method generarParedes() {
    // Límites exteriores del laberinto
    (0..14).forEach({n => posicionParedes.add(new Position(x = n, y = 0))}) // Línea superior
    (0..14).forEach({n => posicionParedes.add(new Position(x = n, y = 12))}) // Línea inferior
    (1..10).forEach({n => posicionParedes.add(new Position(x = 0, y = n))})  // Lateral izquierdo
    (2..12).forEach({n => posicionParedes.add(new Position(x = 14, y = n))}) // Lateral derecho

    // Paredes internas horizontales
    (3..9).forEach({n => posicionParedes.add(new Position(x = n, y = 2))})
    //(1..4).forEach({n => posicionParedes.add(new Position(x = n, y = 4))})
    (7..12).forEach({n => posicionParedes.add(new Position(x = n, y = 6))})
    (2..6).forEach({n => posicionParedes.add(new Position(x = n, y = 8))})
    (10..12).forEach({n => posicionParedes.add(new Position(x = n, y = 10))})

    // Paredes internas verticales
    (3..7).forEach({n => posicionParedes.add(new Position(x = 2, y = n))})
    (5..10).forEach({n => posicionParedes.add(new Position(x = 6, y = n))})
    (4..8).forEach({n => posicionParedes.add(new Position(x = 10, y = n))})
    (8..11).forEach({n => posicionParedes.add(new Position(x = 12, y = n))})

    // Posiciones individuales para añadir variedad
    posicionParedes.addAll([
        new Position(x = 5, y = 3), new Position(x = 8, y = 5),
        new Position(x = 4, y = 7), new Position(x = 10, y = 9)
    ])

    // Creación de paredes y dibujo
    posicionParedes.forEach({p => 
        const nuevaPared = new Paredes(position = p)
        paredes.add(nuevaPared)
        self.dibujar(nuevaPared)
    })
}

	method generarLlave() {
		const llaves = [new Position(x = 1, y = 1), new Position(x = 11, y = 11), 
		new Position(x = 5, y = 4)].map({p => self.dibujar(new Llave(position = p))})
	}

	method generarPuntos() {
		self.generarPuntosRelojP()
		self.generarPuntosRelojN()
		self.generarPuntosP()
		self.generarPuntosN()
	}

	method generarPuntosRelojP() {
		[4, 7].forEach({n => posicionesRelojP.add(new Position(x = 1, y = n))})
		[5, 9].forEach({n => posicionesRelojP.add(new Position(x = 5, y = n))})
		[1, 11].forEach({n => posicionesRelojP.add(new Position(x = 7, y = n))})
		[6, 10].forEach({n => posicionesRelojP.add(new Position(x = 13, y = n))})

		posicionesRelojP.addAll([new Position(x = 11, y = 7), new Position(x = 9, y = 4)])

		posicionesRelojP.forEach({posicionesRelojP => self.dibujar(new PuntosRelojPos(position = posicionesRelojP))})
	}

	method generarPuntosRelojN() {
		posicionesRelojN.addAll([new Position(x = 3, y = 1), new Position(x = 5, y = 11),
		new Position(x = 11, y = 5), new Position(x = 3, y = 9),
		new Position(x = 7, y = 8), new Position(x = 9, y = 10)])

		posicionesRelojN.forEach({posicionesRelojN => self.dibujar(new PuntosRelojNeg(position = posicionesRelojN))})
	}

	method generarPuntosP() {
		[3, 10].forEach({n => posicionesPuntosP.add(new Position(x = 1, y = n))})
		[10].forEach({n => posicionesPuntosP.add(new Position(x = 2, y = n))})
		[3, 11].forEach({n => posicionesPuntosP.add(new Position(x = 3, y = n))})
		[10].forEach({n => posicionesPuntosP.add(new Position(x = 5, y = n))})
		[3, 5].forEach({n => posicionesPuntosP.add(new Position(x = 7, y = n))})
		[9, 11].forEach({n => posicionesPuntosP.add(new Position(x = 9, y = n))})
		[1, 4, 8].forEach({n => posicionesPuntosP.add(new Position(x = 11, y = n))})
		[3, 5].forEach({n => posicionesPuntosP.add(new Position(x = 13, y = n))})


		posicionesPuntosP.forEach({posicionesPuntosP => self.dibujar(new PuntosPersonajePos(position = posicionesPuntosP))})
	}

	method generarPuntosN() {
		posicionesPuntosN.addAll([new Position(x = 2, y = 2), new Position(x = 3, y = 6), new Position(x = 13, y = 8)])

		[8, 9].forEach({n => posicionesPuntosN.add(new Position(x = 1, y = n))})
		[3, 11].forEach({n => posicionesPuntosN.add(new Position(x = 6, y = n))})
		[2, 11].forEach({n => posicionesPuntosN.add(new Position(x = 10, y = n))})

		posicionesPuntosN.forEach({posicionesPuntosN => self.dibujar(new PuntosPersonajeNeg(position = posicionesPuntosN))})
	}


	method terminarJuego() {
		if(self.puedeGanar()) {
			game.clear() 
			nivel2.iniciar() //ver
		}	
		/*else if(self.noGano()) { //sacar? porque evalua ya con el reloj si se quedó sin tiempo
			//perdiste.aparecer()
			reloj.pararTiempo()
		}*/
	}

	method dibujar(dibujo) {
		game.addVisual(dibujo)
	}

	method puedeGanar() = personaje.puedePasar() && personaje.position() == puerta.position() && reloj.hayTiempo()

	method noGano() = not reloj.hayTiempo() // || not personaje.tieneVida() //vidas = nivel 2

	method reiniciar() {
		game.clear()
		personaje.position(inicioPersonaje)
		personaje.reiniciarPuntos()
		personaje.reiniciarLlaves()
		reloj.reiniciarTiempo()
		self.limpiarParedes()
		self.iniciar()
	}

	method limpiarParedes() {
		//paredes.forEach({p => game.removeVisual(p)}) //funciona sin este, pero es mejor dejarlo o sacarlo?
		posicionParedes.removeAll(posicionParedes)
	}//limpiar puntos???
}



//?????? herencia de niveles? agrupar cosas que tienen en comun?
//pero no hay varios nivel1 ni varios nivel2
object nivel2 {
  	const ganaste = new Visual(image = "ganaste.jpg")
	const perdiste = new Visual(image = "perdiste.jpg")
	const controles = new Visual(image = "controles.jpg")
	const pausa = new Visual(image = "pausa.jpg")
	const inicio = new Visual(image = "inicio.jpg")
	const visuales = [inicio, pausa, controles, ganaste, perdiste]
	const posicionParedes = []
	const paredes = []
	const posicionesRelojP = []
	const posicionesRelojN = []
	const posicionesPuntosP = []
	const posicionesPuntosN = []
	const inicioPersonaje = game.at(0, 11)
	const inicioPuerta = game.at(14, 1)
	const fantasma1 = new Enemigo(position = game.at(11, 8))
	const fantasma2 = new Enemigo(position = game.at(4, 1))
	const fantasma3 = new Enemigo(position = game.at(8, 11))
	const enemigos = [fantasma1, fantasma2, fantasma3] //es de prueba, si sirve, se deja



    method iniciar() {
		
        game.height(15)
	    game.width(15)
        game.cellSize(63)

        game.boardGround("fondo.jpg")
		//fondo.configurar("fondotierra2.jpg")

		self.generarParedes()

		
		personaje.position(inicioPersonaje)
        personaje.iniciar()

		self.generarFantasmas()
		self.visibilidadFantasmas()

		puerta.position(inicioPuerta)
		puerta.aparecer()

		game.onCollideDo(personaje, {algo => algo.teAgarraron()})

		reloj.reiniciarTiempo()
		reloj.iniciar()

		self.generarLlave()
		self.generarPuntos()

		self.terminarJuego()

    // Control para finalizar el juego
    keyboard.f().onPressDo({
        game.clear() // Limpiar el estado del juego
        self.eliminarVisuales(visuales)
        reloj.pararTiempo() // Detener el reloj

        // Mostrar mensaje final
        if(self.puedeGanar()) {
            ganaste.aparecer()
        } else {
            perdiste.aparecer()
        }
    })

		keyboard.right().onPressDo({
			if(not self.hayVisual(visuales)) //aca o en el metodo de moverse? pq seria una pausa para personaje/s y tiempo
				personaje.moveteADerecha(self.posicionesParedes(paredes)) //??????
		})
		keyboard.left().onPressDo({
			if(not  self.hayVisual(visuales))
				personaje.moveteAIzquierda(self.posicionesParedes(paredes)) //??????
		})
		keyboard.up().onPressDo({
			if(not self.hayVisual(visuales))
				personaje.moveteArriba(self.posicionesParedes(paredes)) //??????
		})
		keyboard.down().onPressDo({
			if(not self.hayVisual(visuales))
				personaje.moveteAbajo(self.posicionesParedes(paredes)) //??????
		})

		keyboard.enter().onPressDo({
			self.eliminarVisuales(visuales)
			reloj.iniciar() //no se reanuda
		})

		keyboard.p().onPressDo({
				self.eliminarVisuales(visuales)
				reloj.pararTiempo() //despues no se puede reanudar
				pausa.aparecer() 
		})

		keyboard.c().onPressDo({
			self.eliminarVisuales(visuales)
			reloj.pararTiempo() //despues no se puede reanudar
			controles.aparecer()
		})

		keyboard.r().onPressDo({
			self.reiniciar() //ver como reiniciar (o si no se reinicia) //como seria reiniciar para el nivel 2? se pisarian? VER
		})

		keyboard.i().onPressDo({
			self.eliminarVisuales(visuales)
			self.reiniciar()
			reloj.pararTiempo() //despues no se puede reanudar
			inicio.aparecer()
		})

    }
	method eliminarVisuales(lista) {
		const activos = lista.filter({v => game.hasVisual(v)})
		if(self.hayVisual(lista)) 
				activos.forEach({v => game.removeVisual(v)})
	}

	method hayVisual(lista) = lista.any({v => game.hasVisual(v)})

	method posicionesParedes(listaParedes) = listaParedes.map({p => p.position()})

	method generarParedes() {
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
		
		
		posicionParedes.forEach({p => 
		const nuevaPared = new Paredes(position = p)
		paredes.add(nuevaPared)
		self.dibujar(nuevaPared)}) //raro
	}

	method generarLlave() {

		const llaves = [new Position(x = 13, y = 8), new Position(x = 5, y = 2), 
		new Position(x = 9, y = 11)].map({p => self.dibujar(new Llave(position = p))})
	}

	method generarFantasmas() {
		enemigos.forEach({f => f.aparecer()})
	}

	method visibilidadFantasmas() {
		enemigos.forEach({f => f.iniciarParpadeo()})
	}

	method generarPuntos() {
		self.generarPuntosRelojP()
		self.generarPuntosRelojN()
		self.generarPuntosP()
		self.generarPuntosN()
	}

	method generarPuntosRelojP() {
		[4, 7].forEach({n => posicionesRelojP.add(new Position(x = 1, y = n))})
		[5, 9].forEach({n => posicionesRelojP.add(new Position(x = 5, y = n))})
		[1, 6, 11].forEach({n => posicionesRelojP.add(new Position(x = 7, y = n))})
		[6, 10].forEach({n => posicionesRelojP.add(new Position(x = 13, y = n))})

		posicionesRelojP.addAll([new Position(x = 11, y = 7), new Position(x = 9, y = 4)])

		posicionesRelojP.forEach({posicionesRelojP => self.dibujar(new PuntosRelojPos(position = posicionesRelojP))})
	}

	method generarPuntosRelojN() {
		posicionesRelojN.addAll([new Position(x = 3, y = 1), new Position(x = 5, y = 11),
		new Position(x = 11, y = 5), new Position(x = 2, y = 6), new Position(x = 3, y = 9),
		new Position(x = 7, y = 8), new Position(x = 9, y = 10)])

		posicionesRelojN.forEach({posicionesRelojN => self.dibujar(new PuntosRelojNeg(position = posicionesRelojN))})
	}

	method generarPuntosP() {
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


	method generarPuntosN() {
		posicionesPuntosN.addAll([new Position(x = 2, y = 2), new Position(x = 3, y = 6),
		new Position(x = 5, y = 8), new Position(x = 12, y = 8)])

		[8, 9].forEach({n => posicionesPuntosN.add(new Position(x = 1, y = n))})
		[2, 8].forEach({n => posicionesPuntosN.add(new Position(x = 6, y = n))})
		[2, 11].forEach({n => posicionesPuntosN.add(new Position(x = 10, y = n))})

		posicionesPuntosN.forEach({posicionesPuntosN => self.dibujar(new PuntosPersonajeNeg(position = posicionesPuntosN))})
	}


	method terminarJuego() {
		if(self.puedeGanar()) {
			game.clear() 
			ganaste.aparecer() //ver
		}	
		else if(self.noGano()) {
			game.clear()
			perdiste.aparecer()
			reloj.pararTiempo()
		} //ver
	}

	method dibujar(dibujo) {
		game.addVisual(dibujo)
	}

	method puedeGanar() = personaje.puedePasar() && personaje.position() == puerta.position() && reloj.hayTiempo() && personaje.tieneVida()

	method noGano() = not reloj.hayTiempo() || not personaje.tieneVida()

	method reiniciar() {
		game.clear()
		personaje.position(inicioPersonaje)
		personaje.reiniciarPuntos()
		personaje.reiniciarLlaves()
		//personaje.reiniciarVidas() //no funciona....
		reloj.reiniciarTiempo()
		self.limpiarParedes()
		self.iniciar()
	} //ver

	method limpiarParedes() {
		//paredes.forEach({p => game.removeVisual(p)}) //funciona sin este, pero es mejor dejarlo o sacarlo?
		posicionParedes.removeAll(posicionParedes)
	} //limpiar puntos???
}
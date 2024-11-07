import wollok.game.*
import example.*
import elementos.*
import paredes.*





object nivel1 {
   
    method iniciar() {
		
		const posicionParedes = []

		(0.. 24).forEach({n => posicionParedes.add(new Position(x = n, y = 0))})
		(0.. 22).forEach({n => posicionParedes.add(new Position(x = 0, y = n))})
		(1 .. 24).forEach({n => posicionParedes.add(new Position(x = n, y = 24))})
		(2 .. 24).forEach({n => posicionParedes.add(new Position(x = 24, y = n))})
		(1.. 4).forEach({n => posicionParedes.add(new Position(x = n, y = 2))})
		(1.. 4).forEach({n => posicionParedes.add(new Position(x = n, y = 6))})
		(1.. 4).forEach({n => posicionParedes.add(new Position(x = n, y = 12))})
		(1.. 4).forEach({n => posicionParedes.add(new Position(x = n, y = 18))})
		(1.. 2).forEach({n => posicionParedes.add(new Position(x = n, y = 22))})
		(2.. 10).forEach({n => posicionParedes.add(new Position(x = n, y = 4))})
		(2.. 10).forEach({n => posicionParedes.add(new Position(x = n, y = 8))})
		(2.. 8).forEach({n => posicionParedes.add(new Position(x = n, y = 16))})
		(4.. 8).forEach({n => posicionParedes.add(new Position(x = n, y = 20))})
		(4.. 8).forEach({n => posicionParedes.add(new Position(x = n, y = 10))})
		(8.. 14).forEach({n => posicionParedes.add(new Position(x = n, y = 2))})
		(16.. 19).forEach({n => posicionParedes.add(new Position(x = n, y = 2))})
		[22, 23].forEach({n => posicionParedes.add(new Position(x = n, y = 2))})
		(8.. 12).forEach({n => posicionParedes.add(new Position(x = n, y = 6))})
		(12.. 18).forEach({n => posicionParedes.add(new Position(x = n, y = 4))})
		(14.. 17).forEach({n => posicionParedes.add(new Position(x = n, y = 6))})
		(20.. 23).forEach({n => posicionParedes.add(new Position(x = n, y = 8))})
		(10.. 14).forEach({n => posicionParedes.add(new Position(x = n, y = 10))})
		(2.. 4).forEach({n => posicionParedes.add(new Position(x = n, y = 14))})
		(8.. 12).forEach({n => posicionParedes.add(new Position(x = n, y = 14))})
		(10.. 12).forEach({n => posicionParedes.add(new Position(x = n, y = 12))})
		[8, 9].forEach({n => posicionParedes.add(new Position(x = n, y = 18))})
		(19.. 23).forEach({n => posicionParedes.add(new Position(x = n, y = 12))})
		(16.. 23).forEach({n => posicionParedes.add(new Position(x = n, y = 16))})
		(11.. 14).forEach({n => posicionParedes.add(new Position(x = n, y = 20))})
		(14.. 16).forEach({n => posicionParedes.add(new Position(x = n, y = 18))})
		(12.. 16).forEach({n => posicionParedes.add(new Position(x = n, y = 22))})
		(16.. 19).forEach({n => posicionParedes.add(new Position(x = n, y = 20))})
		[22, 23].forEach({n => posicionParedes.add(new Position(x = n, y = 20))})
		(20.. 22).forEach({n => posicionParedes.add(new Position(x = n, y = 22))})
		(20.. 22).forEach({n => posicionParedes.add(new Position(x = n, y = 18))})

		(1.. 8).forEach({n => posicionParedes.add(new Position(x = 6, y = n))})
		(10.. 19).forEach({n => posicionParedes.add(new Position(x = 6, y = n))})
		[22, 23].forEach({n => posicionParedes.add(new Position(x = 6, y = n))})
		(15.. 23).forEach({n => posicionParedes.add(new Position(x = 10, y = n))})
		[5, 11].forEach({n => posicionParedes.add(new Position(x = 10, y = n))})
		(7.. 9).forEach({n => posicionParedes.add(new Position(x = 12, y = n))})
		(15.. 18).forEach({n => posicionParedes.add(new Position(x = 12, y = n))})
		[7, 8].forEach({n => posicionParedes.add(new Position(x = 14, y = n))})
		(11.. 16).forEach({n => posicionParedes.add(new Position(x = 14, y = n))})
		(8.. 16).forEach({n => posicionParedes.add(new Position(x = 16, y = n))})
		(17.. 19).forEach({n => posicionParedes.add(new Position(x = 18, y = n))})
		[22, 23].forEach({n => posicionParedes.add(new Position(x = 18, y = n))})
		(5.. 14).forEach({n => posicionParedes.add(new Position(x = 18, y = n))})
		(1.. 6).forEach({n => posicionParedes.add(new Position(x = 20, y = n))})
		[9, 10, 14, 15, 19, 20, 21].forEach({n => posicionParedes.add(new Position(x = 20, y = n))})
		(3.. 6).forEach({n => posicionParedes.add(new Position(x = 22, y = n))})
		[10, 11, 13, 14].forEach({n => posicionParedes.add(new Position(x = 22, y = n))})
		[9, 10, 20, 21].forEach({n => posicionParedes.add(new Position(x = 2, y = n))})
		[21, 22, 13].forEach({n => posicionParedes.add(new Position(x = 4, y = n))})
		[11, 12, 13, 21, 22].forEach({n => posicionParedes.add(new Position(x = 8, y = n))})
		


		posicionParedes.addAll([
			new Position(x = 0, y = 24), new Position(x = 12, y = 3), 
			new Position(x = 14, y = 19), new Position(x = 16, y = 21)])
		
		const paredes = []
		posicionParedes.forEach({p => 
		const nuevaPared = new Paredes(position = p)
		paredes.add(nuevaPared)
		self.dibujar(nuevaPared)}) //raro

		const ganaste = new Visual(image = "ganaste.png")
		const perdiste = new Visual(image = "perdiste.png")
		const controles = new Visual(image = "controles.png")
		const pausa = new Visual(image = "pausa.png")
		const inicio = new Visual(image = "inicio.png")
		const visuales = [inicio, pausa, controles, ganaste, perdiste]

		//game.addVisual(reloj)
		//inicio.aparecer()
        game.height(30)
	    game.width(30)
        game.cellSize(63) //se puede cambiar el tamaño de celda

        game.boardGround("fondotierra2.jpg")

        personaje.iniciar()
        //game.addVisual(visuales.first())
		puerta.aparecer()

		game.onCollideDo(personaje, {algo => algo.teAgarraron()})

		reloj.iniciar() //en otro archivo funciona, pero aca no descuenta tiempo ...

		self.generarLlave()
		self.generarPuntos()

		self.terminarJuego()



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
			reloj.iniciar()
		})

		keyboard.p().onPressDo({
				self.eliminarVisuales(visuales)
				pausa.aparecer()
				reloj.pararTiempo()
		})

		keyboard.c().onPressDo({
			self.eliminarVisuales(visuales)
			controles.aparecer()
			reloj.pararTiempo()
		})

		keyboard.r().onPressDo({
			self.iniciar() //ver como reiniciar (o si no se reinicia)
		})

		keyboard.i().onPressDo({
			self.eliminarVisuales(visuales)
			inicio.aparecer()
			reloj.pararTiempo()
		})

    }
	method eliminarVisuales(lista) {
		if(self.hayVisual(lista)) 
				lista.forEach({v => game.removeVisual(v)})
	}

	method hayVisual(lista) = lista.any({v => game.hasVisual(v)})

	method posicionesParedes(paredes) = paredes.map({p => p.position()}).asList()

	method generarLlave() {
		const llaves = [new Position(x = 1, y = 1), new Position(x = 11, y = 11), 
		new Position(x = 19, y = 17)].map({p => self.dibujar(new Llave(position = p))})
	}

	method generarPuntos() {
	
		const posicionesRelojP = []
		[15, 8, 20].forEach({n => posicionesRelojP.add(new Position(x = 1, y = n))})
		[6, 13].forEach({n => posicionesRelojP.add(new Position(x = 5, y = n))})
		[16, 9, 5, 1].forEach({n => posicionesRelojP.add(new Position(x = 9, y = n))})
		[17, 7].forEach({n => posicionesRelojP.add(new Position(x = 16, y = n))})
		[22, 13, 6].forEach({n => posicionesRelojP.add(new Position(x = 19, y = n))})
		[20, 13].forEach({n => posicionesRelojP.add(new Position(x = 21, y = n))})
		[11, 4].forEach({n => posicionesRelojP.add(new Position(x = 23, y = n))})
		posicionesRelojP.add(new Position(x = 9, y = 21))

		posicionesRelojP.forEach({posicionesRelojP => self.dibujar(new PuntosRelojPos(position = posicionesRelojP))})

		const posicionesRelojN = []
		[19, 15, 10, 5].forEach({n => posicionesRelojN.add(new Position(x = 3, y = n))})
		[14, 9, 6].forEach({n => posicionesRelojN.add(new Position(x = 7, y = n))})
		[13, 19, 7, 3, 22].forEach({n => posicionesRelojN.add(new Position(x = 11, y = n))})
		[14, 8, 1].forEach({n => posicionesRelojN.add(new Position(x = 15, y = n))})
		[7, 4].forEach({n => posicionesRelojN.add(new Position(x = 21, y = n))})
		posicionesRelojN.add(new Position(x = 13, y = 13))

		posicionesRelojN.forEach({posicionesRelojN => self.dibujar(new PuntosRelojNeg(position = posicionesRelojN))})

		const posicionesPuntosP = []
		[1, 2, 4, 5, 7, 8, 16, 17].forEach({n => posicionesPuntosP.add(new Position(x = n, y = 23))})
		(11.. 14).forEach({n => posicionesPuntosP.add(new Position(x = n, y = 23))})
		[19, 21, 22, 23].forEach({n => posicionesPuntosP.add(new Position(x = n, y = 23))})
		(22.. 20).forEach({n => posicionesPuntosP.add(new Position(x = 3, y = n))})
		[17, 13, 11, 9, 1].forEach({n => posicionesPuntosP.add(new Position(x = 3, y = n))})
		[21, 19, 16, 14, 10, 9, 7, 5, 4, 3].forEach({n => posicionesPuntosP.add(new Position(x = 1, y = n))})
		[19, 17, 13, 11, 5, 3].forEach({n => posicionesPuntosP.add(new Position(x = 2, y = n))})
		[19, 17, 9, 7, 5].forEach({n => posicionesPuntosP.add(new Position(x = 4, y = n))})
		[22, 21, 19, 18, 15, 14, 12, 9, 5, 3, 2, 1].forEach({n => posicionesPuntosP.add(new Position(x = 5, y = n))})
		[22, 21, 19, 18, 17, 13, 12, 11, 7, 5, 2, 1].forEach({n => posicionesPuntosP.add(new Position(x = 7, y = n))})
		[21, 9].forEach({n => posicionesPuntosP.add(new Position(x = 6, y = n))})
		[19, 15, 9, 5, 3].forEach({n => posicionesPuntosP.add(new Position(x = 8, y = n))})
		[22, 20, 19, 17, 13, 12, 10, 7, 3].forEach({n => posicionesPuntosP.add(new Position(x = 9, y = n))})
		[9, 3, 1].forEach({n => posicionesPuntosP.add(new Position(x = 10, y = n))})
		[21, 18, 17, 16, 9, 8, 5, 4, 1].forEach({n => posicionesPuntosP.add(new Position(x = 11, y = n))})
		[21, 19, 13, 11, 5, 1].forEach({n => posicionesPuntosP.add(new Position(x = 12, y = n))})
		[21, 19, 18, 17, 16, 14, 12, 9, 8, 7, 6, 5, 3].forEach({n => posicionesPuntosP.add(new Position(x = 13, y = n))})
		[21, 17, 9, 5, 3, 1].forEach({n => posicionesPuntosP.add(new Position(x = 14, y = n))})
		[21, 20, 19, 16, 15, 13, 12, 10, 9, 5, 3, 2].forEach({n => posicionesPuntosP.add(new Position(x = 15, y = n))})
		[19, 5, 1].forEach({n => posicionesPuntosP.add(new Position(x = 16, y = n))})
		[22, 21, 19, 18, 17, 14, 13, 12, 11, 10, 9, 8, 7, 5].forEach({n => posicionesPuntosP.add(new Position(x = 17, y = n))})
		[21, 15, 3, 1].forEach({n => posicionesPuntosP.add(new Position(x = 18, y = n))})
		[21, 19, 18, 15, 14, 10, 9, 8, 7, 5, 4, 3, 1].forEach({n => posicionesPuntosP.add(new Position(x = 19, y = n))})
		[17, 7].forEach({n => posicionesPuntosP.add(new Position(x = 20, y = n))})
		[21, 19, 15, 14, 11, 10, 9, 6, 5, 3, 2].forEach({n => posicionesPuntosP.add(new Position(x = 21, y = n))})
		[21, 19, 17, 15, 9, 7, 1].forEach({n => posicionesPuntosP.add(new Position(x = 22, y = n))})
		[22, 21, 19, 18, 17, 15, 14, 13, 10, 9, 6, 5, 1].forEach({n => posicionesPuntosP.add(new Position(x = 23, y = n))})

		posicionesPuntosP.forEach({posicionesPuntosP => self.dibujar(new PuntosPersonajePos(position = posicionesPuntosP))})

		const posicionesPuntosN = []
		[3, 9, 15, 20].forEach({n => posicionesPuntosN.add(new Position(x = n, y = 23))})
		[1, 5, 8, 15, 21].forEach({n => posicionesPuntosN.add(new Position(x = n, y = 17))})
		[2, 4, 7, 9, 11, 13, 17].forEach({n => posicionesPuntosN.add(new Position(x = n, y = 15))})
		[1, 10, 20].forEach({n => posicionesPuntosN.add(new Position(x = n, y = 13))})
		[1, 4, 5, 9, 13, 15, 19, 20].forEach({n => posicionesPuntosN.add(new Position(x = n, y = 11))})
		[2, 3, 5, 8, 10, 15, 23].forEach({n => posicionesPuntosN.add(new Position(x = n, y = 7))})
		[3, 4, 7, 16, 17, 23].forEach({n => posicionesPuntosN.add(new Position(x = n, y = 3))})
		[2, 4, 8, 13, 17, 21].forEach({n => posicionesPuntosN.add(new Position(x = n, y = 1))})
		posicionesPuntosN.forEach({posicionesPuntosN => self.dibujar(new PuntosPersonajeNeg(position = posicionesPuntosN))})

	}

	method terminarJuego() {
		if(self.puedeGanar()) {
			new Visual(image = "ganaste.jpg").aparecer()
			reloj.pararTiempo()
		}	
		else {
			new Visual(image = "perdiste.jpg").aparecer()
			reloj.pararTiempo()
		}
	}

	method dibujar(dibujo) {
		game.addVisual(dibujo)
		return dibujo
	}

	method puedeGanar() = personaje.puedePasar() && personaje.position() == puerta.position() && reloj.hayTiempo() && personaje.tieneVida()

}



//?????? herencia de niveles? 
/*object nivel2 {
  var tiempo = 0
	const property paredes = new Paredes(muros = [[paredes.coord(1, 0), paredes.coord(1, 1), paredes.coord(2, 1), paredes.coord(3, 1)]])

    method tiempo() = tiempo

    method aumentarTiempo(cantidad) {
        tiempo = tiempo + cantidad
    }

    method restarTiempo(cantidad) {
        tiempo = 0.max(tiempo - cantidad)
    }

    method iniciar() {
    
        game.height(30)
	    game.width(30)
        //game.cellSize(80) //se puede cambiar el tamaño de celda

        //game.boardGround("pruebaFondo.jpg")

        game.addVisualCharacter(personaje)
        game.addVisual(instrucciones)

    }
}*/
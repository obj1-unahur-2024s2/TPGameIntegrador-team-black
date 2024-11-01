import wollok.game.*
import example.*
import elementos.*
import paredes.*


object nivel1 {
    var tiempo = 180000 //3 minutos
	const property paredes = new Paredes(muros = [[paredes.coord(1, 0), paredes.coord(1, 1), paredes.coord(2, 1), paredes.coord(3, 1)]])

    method tiempo() = tiempo

    method aumentarTiempo(cantidad) {
        tiempo = tiempo + cantidad
    }

    method restarTiempo(cantidad) {
        tiempo = 0.max(tiempo - cantidad)
    }

	method pararTiempo() {
		game.removeTickEvent("paso del tiempo")
	}

    method iniciar() {
    
        game.height(30)
	    game.width(30)
        //game.cellSize(80) //se puede cambiar el tamaño de celda

        //game.boardGround("pruebaFondo.jpg")

        game.addVisualCharacter(personaje)
        game.addVisual(instrucciones)
		puerta.aparecer()

		game.onCollideDo(personaje, {algo => algo.teAgarraron()})
		game.onTick(1000, "paso del tiempo", {self.restarTiempo(1)})

		self.generarLlave()
		self.generarPuntos()

		self.terminarJuego()
    }


	method generarLlave() {
		const llaves = new Llave(ubicaciones = [llaves.coord(2, 1), llaves.coord(1, 3), llaves.coord(0, 5)])
		game.addVisual(llaves)
	}

	method generarPuntos() {
		const relojPos = new PuntosRelojPos(ubicaciones = [relojPos.coord(3, 1)], valor = 20)
		const relojNeg = new PuntosRelojNeg(ubicaciones = [relojNeg.coord(2, 2)], valor = 10)
		const puntosPos = new PuntosPersonajePos(ubicaciones = [puntosPos.coord(1, 5)], valor = 1000)
		const puntosNeg = new PuntosPersonajeNeg(ubicaciones = [puntosNeg.coord(2, 4)], valor = 500)

		game.addVisual(relojPos)
		game.addVisual(relojNeg)
		game.addVisual(puntosPos)
		game.addVisual(puntosNeg)

		game.onTick(5000, "visibilidad puntos reloj pos", {relojPos.alternarVisibilidad()})
		game.onTick(5000, "visibilidad puntos reloj neg", {relojNeg.alternarVisibilidad()})
		game.onTick(5000, "visibilidad puntos pos", {puntosPos.alternarVisibilidad()})
		game.onTick(5000, "visibilidad puntos neg", {puntosNeg.alternarVisibilidad()})
	}

	method terminarJuego() {
		if(personaje.puedePasar() && personaje.position() == puerta.position())
			game.stop()
	}

}


//?????? herencia de niveles? pero no hay varios nivel1 ni varios nivel2
object nivel2 {
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
}




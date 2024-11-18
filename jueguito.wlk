import wollok.game.*
import personaje.*
import elementos.*
import paredes.*
import niveles.*


object juego {
    const pantallaPrincipal = new Elemento(image = "inicio.jpg")
    const perdiste = new Elemento(image = "perdiste.jpg")
    const controles = new Elemento(image = "controles.jpg")
    var juegoIniciado = false

    method iniciar() {
        game.height(15)
	    game.width(15)
        game.cellSize(63)

        game.boardGround("fondo.jpg")

        game.addVisual(pantallaPrincipal)

        keyboard.space().onPressDo({
            if(not juegoIniciado) {
                game.clear()
                nivel1.iniciar()
                juegoIniciado = true
            }
        })

        keyboard.c().onPressDo({
			reloj.pararTiempo()
			reloj.desaparecer()
			controles.aparecer()
		})
    }

    method gameOver() {
        game.clear()
        game.addVisual(perdiste)
    }
}






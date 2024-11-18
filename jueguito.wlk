import wollok.game.*
import personaje.*
import elementos.*
import paredes.*
import niveles.*


object juego {
    const pantallaPrincipal = new Elemento(image = "inicio.jpg")
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
    }
}






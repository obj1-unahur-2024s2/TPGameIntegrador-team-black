import example.*
import wollok.game.*
import niveles.*

class Elementos {
    const property ubicaciones = []
    const property image = "" 

    method desaparecer() {
        game.removeVisual(self)
    }

    method teAgarraron()

    method coord(x, y) {
      return game.at(x, y)
    }

    method aparecer() {
        game.addVisual(self)
    }
}

object puerta {
    const property position = game.at(28, 2)
    method image() = ""

    method teAgarraron() { 
        if(personaje.puedePasar()) {
            game.removeVisual(self)
            personaje.usarLlaves()
            personaje.reiniciarPuntos()
            nivel1.pararTiempo()
        }
        else
            game.say(self, "No se puede pasar")
    }

    method aparecer() {
        game.addVisual(self)
        game.say(self, "Para pasar se necesitan 3 llaves y 10500 puntos")
    }

}

class Puntos inherits Elementos {
    const property valor

    method sumar(unValor)
    method restar(unValor)

    method alternarVisibilidad() {
        if(game.hasVisual(self))
            self.desaparecer()
        self.aparecer()
    }
}

class PuntosRelojPos inherits Puntos(image = "") {
    override method sumar(unValor) {
        nivel1.aumentarTiempo(unValor)
        nivel2.aumentarTiempo(unValor) //resta aunque no esté corriendo el nivel 2?
    }

    override method restar(unValor) {}

    override method teAgarraron() {
        self.sumar(valor)
        self.desaparecer()
    }
}

class PuntosRelojNeg inherits Puntos(image = "") {
    override method sumar(unValor) {}

    override method restar(unValor) {
        nivel1.restarTiempo(unValor)
        nivel2.restarTiempo(unValor) //resta aunque no esté corriendo el nivel 2?
    }

    override method teAgarraron() {
        self.restar(valor)
        self.desaparecer()
    }
}


class PuntosPersonajePos inherits Puntos(image = "") {
    override method sumar(unValor) {
        personaje.agarrarPuntos(unValor)
    }

    override method restar(unValor) {}

    override method teAgarraron() {
        self.sumar(valor)
        self.desaparecer()
    }
}

class PuntosPersonajeNeg inherits Puntos(image = "") {
    override method restar(unValor) {
        personaje.perderPuntos(unValor)
    }

    override method sumar(unValor) {}

    override method teAgarraron() {
        self.restar(valor)
        self.desaparecer()
    }
}

class Llave inherits Elementos(image = "") {
    override method teAgarraron() {
        personaje.agarrarLlave(self)
        self.desaparecer()
    }
}


class Enemigo inherits Elementos(image = "") {

}
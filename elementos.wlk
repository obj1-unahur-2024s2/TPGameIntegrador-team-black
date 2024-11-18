import personaje.*
import wollok.game.*
import niveles.*
import jueguito.*

class Elemento {
    const property image = "" 
    var property position = game.origin()

    method desaparecer() {
        if(game.hasVisual(self)){
            game.removeVisual(self)
        }
    }

    method teAgarraron(){}

    method aparecer() {
        if(not(game.hasVisual(self))){
            game.addVisual(self)
        }
    }
}


object reloj {
    var segundosRestantes = 10  
    var property image = "3_00.png"  
    var property position = game.at(4, 13)  

    method iniciar() {
        game.addVisual(self)

        game.onTick(1000, "actualizarReloj", {
            if (self.hayTiempo()) {
                self.restarTiempo(1)
                self.actualizarVisual()
            } else {
                juego.gameOver()
            }
        })
    }

    method actualizarVisual() {
        const minutos = segundosRestantes.div(60)
        const segundos = segundosRestantes % 60
        const nombreImagen = minutos.toString() + "_" + (if (segundos < 10) "0" + segundos else segundos.toString()) + ".png"
    
        self.image(nombreImagen)
    }

    method reiniciarTiempo() {
        segundosRestantes = 180
    }

    method aumentarTiempo(cantidad) {
        segundosRestantes = 180.min(segundosRestantes + cantidad)
        self.actualizarVisual()
    }

    method restarTiempo(cantidad) {
        segundosRestantes = 0.max(segundosRestantes - cantidad)
        self.actualizarVisual()
    }

    method pararTiempo() {
        game.removeTickEvent("actualizarReloj")
    }

	method hayTiempo() = segundosRestantes > 0

    method desaparecer() {
        game.removeVisual(self)
    }
}

object puerta {
    var property position = game.origin()
    method image() = "puerta.png"

    method teAgarraron() { 
        if(personaje.puedePasar()) {
            game.removeVisual(self)
            personaje.usarLlaves()
            personaje.reiniciarPuntos()
            personaje.reiniciarLlaves()
            reloj.pararTiempo()
            game.removeVisual(personaje)
        }
        else
            game.say(self, "No se puede pasar")
    }

    method aparecer() {
        game.addVisual(self)
        game.say(self, "Para pasar se necesitan 3 llaves y 8500 puntos")
    }
}

class Puntos inherits Elemento {
    const property valor

    method sumar(unValor)
    method restar(unValor)
}

class PuntosRelojPos inherits Puntos(image = "reloj-pos.png", valor = 20) {
    override method sumar(unValor) {
        reloj.aumentarTiempo(unValor)
    }

    override method restar(unValor) {}

    override method teAgarraron() {
        self.sumar(valor)
        self.desaparecer()
    }
}

class PuntosRelojNeg inherits Puntos(image = "reloj-neg.png", valor = 10) {
    override method sumar(unValor) {}

    override method restar(unValor) {
        reloj.restarTiempo(unValor)
    }

    override method teAgarraron() {
        self.restar(valor)
        self.desaparecer()
    }
}


class PuntosPersonajePos inherits Puntos(image = "puntos-pos.png", valor = 1000) {
    override method sumar(unValor) {
        personaje.agarrarPuntos(unValor)
    }

    override method restar(unValor) {}

    override method teAgarraron() {
        self.sumar(valor)
        self.desaparecer()
    }
}

class PuntosPersonajeNeg inherits Puntos(image = "puntos-neg.png", valor = 500) {
    override method restar(unValor) {
        personaje.perderPuntos(unValor)
    }

    override method sumar(unValor) {}

    override method teAgarraron() {
        self.restar(valor)
        self.desaparecer()
    }
}

class Llave inherits Elemento(image = "llave.png") {
    override method teAgarraron() {
        personaje.agarrarLlave(self)
        self.desaparecer()
    }
}

class Enemigo inherits Elemento(image = "fantasmaBlanco.png") {
    var seVe = true
    method iniciarParpadeo() {
        game.onTick(3000, "parpadeoFantasma" , {
            if (seVe) {
                seVe=false
                self.desaparecer()
            } else {
                seVe = true
                self.aparecer()
            }
        })
    }

    override method teAgarraron() {
        personaje.perderVida()
        self.desaparecer()
    }

    method cortarParpadeo() {
        self.desaparecer()
        seVe = false
        game.removeTickEvent("parpadeoFantasma")
    }
    
}


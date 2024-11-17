import personaje.*
import wollok.game.*
import niveles.*

class Elementos {
    const property ubicaciones = []
    const property image = "" 
    var property position = game.at(0, 0)

    method desaparecer() {
        game.removeVisual(self)
    }

    method teAgarraron(){} //?

    method aparecer() {
        game.addVisual(self)
    }
}


object reloj {
    var segundosRestantes = 180  // 3 minutos en segundos
    var property image = "3_00.png"  // Imagen inicial (3:00)
    var property position = game.at(4, 13)  

    method iniciar() {
        game.addVisual(self)

        game.onTick(1000, "actualizarReloj", {
            if (self.hayTiempo()) {
                self.restarTiempo(1)
                self.actualizarVisual()
            } else {
                self.tiempoAgotado()
            }
        })
    }

    method actualizarVisual() {
        const minutos = segundosRestantes.div(60)
        const segundos = segundosRestantes % 60
        const nombreImagen = minutos.toString() + "_" + (if (segundos < 10) "0" + segundos else segundos.toString()) + ".png"
    
        self.image(nombreImagen)
    }

    method tiempoAgotado() { //ver
        game.addVisual(new Visual(image = "perdiste.jpg"))
        self.pararTiempo()
        self.reiniciarTiempo() //se reinicia aunque no se reinicie el juego, dejar?
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
}

object puerta {
    var property position = game.origin()
    method image() = "puerta.png"

    method teAgarraron() { 
        if(personaje.puedePasar()) {
            game.removeVisual(self)
            personaje.usarLlaves()
            personaje.reiniciarPuntos()
            personaje.reiniciarLlaves() //reiniciar vidas??
            reloj.pararTiempo()
            game.removeVisual(personaje)
        }
        else
            game.say(self, "No se puede pasar") //se ve chiquito + a veces habla, a veces no
    }

    method aparecer() {
        game.addVisual(self)
        game.say(self, "Para pasar se necesitan 3 llaves y 10500 puntos") //se ve chiquito + a veces habla, a veces no
    }
}

class Puntos inherits Elementos {
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

class Llave inherits Elementos(image = "llave.png") {
    override method teAgarraron() {
        personaje.agarrarLlave(self)
        self.desaparecer()
    }
}

class Enemigo inherits Elementos(image = "fantasma.png") {
    var seVe = true
    // Método para iniciar el parpadeo del enemigo cada 3 segundos
    method iniciarParpadeo() {
        game.onTick(3000, "parpadeoFantasma" , {
            // Alternar visibilidad del enemigo
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
        self.desaparecer() // Desaparece después de afectar al personaje
    }
}

class Visual {
    const property image = ""

    method position() = game.origin()

    method desaparecer() {
        game.removeVisual(self)
    }

    method aparecer() {
        game.addVisual(self)
    }
}
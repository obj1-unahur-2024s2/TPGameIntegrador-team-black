import example.*
import wollok.game.*
import niveles.*

class Elementos {
    const property ubicaciones = []
    const property image = "" 
    var property position = game.at(0, 0)

    method desaparecer() {
        game.removeVisual(self)
    }

    method teAgarraron() {}

    method coord(x, y) {
      return game.at(x, y)
    }

    method aparecer() {
        game.addVisual(self)
    }

    method agregarUb(posiciones) {
        ubicaciones.addAll(posiciones)
    }
}

object reloj {
    var segundosRestantes = 180  
    var property image = "3_00.png"  
    var property position = game.at(5, 26) 

    method iniciar() {
        
        game.addVisual(self)
        
        game.onTick(1000, "actualizarReloj", {
            if (segundosRestantes > 0) {
                self.restarTiempo(1)
                self.actualizarVisual()
            } else {
                game.removeVisual(self)  
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
        game.addVisual("perdiste.png")
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
    const property position = game.at(24, 1)
    method image() = "puerta.png"

    method teAgarraron() { 
        if(personaje.puedePasar()) {
            game.removeVisual(self)
            personaje.usarLlaves()
            personaje.reiniciarPuntos()
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

    method alternarVisibilidad() {
        if(game.hasVisual(self))
            self.desaparecer()
        else
            self.aparecer()
    }
}

class PuntosRelojPos inherits Puntos(image = "reloj-pos.png", valor = 20) {
    override method sumar(unValor) {
        reloj.aumentarTiempo(unValor)
        //nivel2.aumentarTiempo(unValor) //resta aunque no esté corriendo el nivel 2?
    }

    override method restar(unValor) {}

    override method teAgarraron() {
        self.sumar(valor)
        //game.removeTickEvent("visibilidad puntos reloj pos")
        self.desaparecer()
    }
}

class PuntosRelojNeg inherits Puntos(image = "reloj-neg.png", valor = 10) {
    override method sumar(unValor) {}

    override method restar(unValor) {
        reloj.restarTiempo(unValor)
       // nivel2.restarTiempo(unValor) //resta aunque no esté corriendo el nivel 2?
    }

    override method teAgarraron() {
        self.restar(valor)
        //game.removeTickEvent("visibilidad puntos reloj neg")
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
        game.removeTickEvent("visibilidad puntos pos")
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
        game.removeTickEvent("visibilidad puntos neg")
        self.desaparecer()
    }
}

class Llave inherits Elementos(image = "llave.png") {
    override method teAgarraron() {
        personaje.agarrarLlave(self)
        self.desaparecer()
    }
}


class Enemigo inherits Elementos(image = "") {
    
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
import wollok.game.*
import paredes.*
import elementos.*


object personaje {
  var position = game.at(0, 23) //game.origin() es 0;0
  const vida1 = new Elementos(position = game.at(10, 26), image = "corazon.png")
  const vida2 = new Elementos(position = game.at(11, 26), image = "corazon.png")
  const vida3 = new Elementos(position = game.at(12, 26), image = "corazon.png")

  var vidas = 3

  var puntos = 0

  const property llaves = [] 

  const property visualesVidas = [vida1, vida2, vida3]

  method iniciar() {
    game.addVisual(self)
    visualesVidas.forEach({v => v.aparecer()})
  }


  method vidas() = vidas

  method puntos() = puntos

  method agarrarLlave(unaLlave) {
    llaves.add(unaLlave)
  }

  method usarLlaves() {
    llaves.clear()
  }

  method perderVida() {
    vidas = 0.max(vidas - 1)
    if(vidas > 0) {
      game.removeVisual(visualesVidas.last())
      visualesVidas.remove(visualesVidas.last())
    }
  }

  method ganarVida() {
    vidas = 3.min(vidas + 1)
    if(vidas == 2)
      vida3.aparecer()
    else if(vidas == 1) {
      vida2.aparecer()
      vida3.aparecer()
    }
  }

  method tieneVida() = vidas > 0

  method agarrarPuntos(cantidad) {
    puntos = puntos + cantidad
    game.say(self, "Tengo " + puntos + " !" ) //se ve chiquito + a veces habla, a veces no
  }

  method perderPuntos(cantidad) {
    puntos = 0.max(puntos - cantidad)
    game.say(self, "Tengo " + puntos + " !" ) //se ve chiquito + a veces habla, a veces no
  }

  method reiniciarPuntos() {
    puntos = 0
  }

  method puedePasar() {
        return self.llaves().size() == 3 && self.puntos() >= 10500
    }
  
  method image() = "personaje.png" //que cambie cuando cambia de direccion? //sacar el de personita

  method position() = position

  method moveteADerecha(posiciones) {
    const nuevaDireccion = game.at((game.width()-1).min(position.x() + 1), position.y())
    if(not posiciones.contains(nuevaDireccion))
      position = nuevaDireccion
  }

  method moveteAIzquierda(posiciones) {
    const nuevaDireccion = game.at(0.max(position.x()-1), position.y())
    if(not posiciones.contains(nuevaDireccion))
      position = nuevaDireccion
  }

  method moveteArriba(posiciones) {
    const nuevaDireccion = game.at(position.x(), (game.height()-1).min(position.y() + 1))
    if(not posiciones.contains(nuevaDireccion))
      position = nuevaDireccion
  }

  method moveteAbajo(posiciones) {
    const nuevaDireccion = game.at(position.x(), 0.max(position.y()-1))
    if(not posiciones.contains(nuevaDireccion))
      position = nuevaDireccion
  }

  method hayParedEn(posicion) = Paredes.muros().contains(posicion) //ver
}
import niveles.*
import wollok.game.*
import paredes.*
import elementos.*


object personaje {
  var property position = game.origin()
  const vida1 = new Elemento(position = game.at(9, 13), image = "corazon.png")
  const vida2 = new Elemento(position = game.at(10, 13), image = "corazon.png")
  const vida3 = new Elemento(position = game.at(11, 13), image = "corazon.png")
  var vidas = 3
  var puntos = 0
  var nivelActual = nivel1
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
    if(vidas > 0) {
      game.removeVisual(visualesVidas.last())
      visualesVidas.remove(visualesVidas.last())
    }
    vidas = 0.max(vidas - 1) //o adentro del if sin el 0.max
  }


  method tieneVida() = vidas > 0

  method agarrarPuntos(cantidad) {
    puntos = puntos + cantidad
    game.say(self, "Tengo " + puntos + " !" )
  }

  method perderPuntos(cantidad) {
    puntos = 0.max(puntos - cantidad)
    game.say(self, "Tengo " + puntos + " !" )
  }

  method reiniciarPuntos() {
    puntos = 0
  }

  method reiniciarLlaves() {
    llaves.removeAll(llaves)
  }

  method reiniciarVidas() {
    if(vidas < 3) {
      vidas = 3
      visualesVidas.clear()
      visualesVidas.addAll([vida1, vida2, vida3])
    }
  }

  method puedePasar() {
        return self.llaves().size() == 3 && self.puntos() >= 8500
  }
  
  method image() = "personaje.png"

  method position() = position

  method moveteADerecha(posiciones) {
    const nuevaDireccion = game.at((game.width()-1).min(position.x() + 1), position.y())
    if(not posiciones.contains(nuevaDireccion))
      position = nuevaDireccion
    nivelActual.terminarNivel()
  }

  method cambiarNivel() {
    nivelActual = nivel2
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
}
import wollok.game.*
import paredes.*

object paredes {
    const property muros = [self.coord(1, 0), self.coord(1, 1), self.coord(2, 1), self.coord(3, 1)]
    //const property position = game.origin()

    method coord(x, y) {
      return game.at(x, y)
    }

    //method establecerImagen() = muros.forEach({m => m.image()})

    //method image() = "cuadrado.png"
}

object instrucciones {
    method position() = game.center()

    method text() = "holaholaholaholaholaholaholaholaholahola
    holaholaholaholaholaholaholaholaholahola" //en texto o imagen con las instrucciones, no se
}

object personaje {
  var position = game.at(0, 1) //game.origin() es 0;0

  var vidas = 3

  var puntos = 0

  const property llaves = [] 

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
  }

  method ganarVida() {
    vidas = 3.min(vidas + 1)
  }

  method agarrarPuntos(cantidad) {
    puntos = puntos + cantidad
  }

  method perderPuntos(cantidad) {
    puntos = 0.max(puntos - cantidad)
  }

  method reiniciarPuntos() {
    puntos = 0
  }

  method puedePasar() {
        return self.llaves().size() == 3 && self.puntos() >= 10500
    }
  
  method image() = "personita.png"

  method position() = position

  method moveteADerecha(pared) {
    const nuevaDireccion = game.at((game.width()-1).min(position.x() + 1), position.y())
    if(not pared.muros().contains(nuevaDireccion))
      position = nuevaDireccion
  }

  method moveteAIzquierda(pared) {
    const nuevaDireccion = game.at(0.max(position.x()-1), position.y())
    if(not pared.muros().contains(nuevaDireccion))
      position =  nuevaDireccion
  }

  method moveteArriba(pared) {
    const nuevaDireccion = game.at(position.x(), (game.height()-1).min(position.y() + 1))
    if(not pared.muros().contains(nuevaDireccion))
      position = nuevaDireccion
  }

  method moveteAbajo(pared) {
    const nuevaDireccion = game.at(position.x(), 0.max(position.y()-1))
    if(not pared.muros().contains(nuevaDireccion))
      position = nuevaDireccion
  }
}
class Paredes {
    const property muros = []
    var property position
    const property puedeAvanzar = false

    method coord(x, y) {
      return game.at(x, y)
    }

    method agregar(coordenadas) {
      muros.addAll(coordenadas)
    }

    method image() = "tumba.png"
}
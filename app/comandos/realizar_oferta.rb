require_relative 'comando'

class RealizarOferta < Comando
  def ejecutar(publicacion, precio, usuario)
    oferta = Oferta.new(precio, usuario, publicacion)
    # guardar_publicacion(publicacion)
    guardar_oferta(oferta)
  end
end

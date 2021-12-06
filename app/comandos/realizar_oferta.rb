require_relative 'comando'

class RealizarOferta < Comando
  def ejecutar(monto, oferente, publicacion)
    raise PublicacionVendidaError if publicacion.estado == EstadoVendido.new

    oferta = Oferta.new(monto, oferente, publicacion)
    # guardar_publicacion(publicacion)
    guardar_oferta(oferta)
  end
end

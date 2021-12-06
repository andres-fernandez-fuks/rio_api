require_relative 'comando'

class RealizarOferta < Comando
  def ejecutar(monto, oferente, publicacion)
    oferta = Oferta.new(monto, oferente, publicacion)
    # guardar_publicacion(publicacion)
    guardar_oferta(oferta)
  end
end

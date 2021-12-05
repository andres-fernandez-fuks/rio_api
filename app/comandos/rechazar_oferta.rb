require_relative 'comando'

class RechazarOferta < Comando
  def ejecutar(oferta)
    publicacion = oferta.publicacion
    publicacion.activar if oferta.fiubak?
    oferta.rechazar
    guardar_publicacion(publicacion)
    guardar_oferta(oferta)
  end
end

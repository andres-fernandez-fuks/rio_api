require_relative 'comando'
require_relative '../models/errors/errores'

FACTOR_INCREMENTO_DE_PRECIO = 1.3

class AceptarOferta < Comando
  def ejecutar(oferta)
    publicacion = oferta.publicacion
    raise PublicacionVendidaError unless publicacion.estado != EstadoVendido.new

    estado_previo_a_aceptar = publicacion.estado
    publicacion.vendida
    oferta.aceptar
    guardar_cambios(oferta, publicacion)
    if estado_previo_a_aceptar == EstadoCotizado.new
      publicacion_nueva = PublicacionFiubak.new(oferta.monto * FACTOR_INCREMENTO_DE_PRECIO, usuario_fiubak, publicacion.auto)
      publicacion_nueva.activar
      guardar_publicacion(publicacion_nueva)
    end
    oferta
  end

  private

  def guardar_cambios(oferta, publicacion)
    guardar_publicacion(publicacion)
    guardar_oferta(oferta)
  end
end

require_relative 'comando'
require_relative '../models/errors/errores'
require_relative '../models/oferta_aceptada'

FACTOR_INCREMENTO_DE_PRECIO = 1.3

# rubocop: disable Metrics/AbcSize
class AceptarOferta < Comando
  def ejecutar(oferta)
    publicacion = oferta.publicacion
    raise PublicacionVendidaError unless publicacion.estado != EstadoVendido.new

    estado_previo_a_aceptar = publicacion.estado
    publicacion.vendida
    oferta.aceptar
    guardar_cambios(oferta, publicacion)
    id_publicacion_nueva = nil
    if estado_previo_a_aceptar == EstadoCotizado.new
      publicacion_nueva = PublicacionFiubak.new(oferta.monto * FACTOR_INCREMENTO_DE_PRECIO, usuario_fiubak, publicacion.auto)
      publicacion_nueva.activar
      id_publicacion_nueva = guardar_publicacion(publicacion_nueva).id
    end
    OfertaAceptada.new(oferta, id_publicacion_nueva)
  end

  private

  def guardar_cambios(oferta, publicacion)
    guardar_publicacion(publicacion)
    guardar_oferta(oferta)
  end
end
# rubocop: enable Metrics/AbcSize

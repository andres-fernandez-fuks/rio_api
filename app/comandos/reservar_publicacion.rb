require_relative 'comando'
require_relative '../models/errors/errores'

class ReservarPublicacion < Comando
  def ejecutar(publicacion)
    publicacion.reservar
    guardar_publicacion(publicacion)
  end
end

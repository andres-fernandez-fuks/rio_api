require_relative 'comando'

class RegistrarAuto < Comando
  def ejecutar(publicacion)
    raise PatenteYaRegistradaError if patente_registrada?(publicacion.patente_de_auto)

    guardar_auto(publicacion.auto)
    guardar_publicacion(publicacion)
  end

  def patente_registrada?(patente)
    patente_duplicada_en_activas = !publicaciones_con_patente(patente, EstadoActivo.new.id).empty?
    patente_duplicada_cotizacion = !publicaciones_con_patente(patente, EstadoCotizado.new.id).empty?
    patente_duplicada_en_revision = !publicaciones_con_patente(patente, EstadoRevision.new.id).empty?
    patente_duplicada_en_activas || patente_duplicada_cotizacion || patente_duplicada_en_revision
  end

  def publicaciones_con_patente(patente, estado)
    repo_de_publicaciones.buscar_por_patente_y_estado(patente, estado)
  end
end

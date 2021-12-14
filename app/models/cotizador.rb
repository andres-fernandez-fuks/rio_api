require_relative '../comandos/cotizacion_exitosa'
require_relative '../comandos/cotizacion_fallida'
require_relative './informe_de_revision'
class Cotizador
  PENALIDAD_NO_MOTORICA = {
    InformeDeRevision::GRAVEDAD_NULA => 0,
    InformeDeRevision::GRAVEDAD_LEVE => 0.03,
    InformeDeRevision::GRAVEDAD_GRAVE => 0.08
  }.freeze

  PENALIDAD_MOTORICA = {
    InformeDeRevision::GRAVEDAD_NULA => 0,
    InformeDeRevision::GRAVEDAD_LEVE => 0.03,
    InformeDeRevision::GRAVEDAD_GRAVE => 0.10
  }.freeze

  def cotizar(publicacion, informe)
    return CotizacionFallida.new(publicacion, Persistence::Repositories::RepositorioPublicaciones.new) if es_fallida?(publicacion.auto, informe)

    precio = precio_base(publicacion.auto) - porcentaje_a_descontar(informe) * precio_base(publicacion.auto)
    CotizacionExitosa.new(publicacion, precio, Persistence::Repositories::RepositorioOfertas.new, Persistence::Repositories::RepositorioPublicaciones.new,
                          Persistence::Repositories::RepositorioUsuarios.new)
  end

  private

  def porcentaje_a_descontar(informe)
    porcentaje_por_falla_no_motorica(informe.falla_estetica) + porcentaje_por_falla_no_motorica(informe.falla_de_neumaticos) + porcentaje_por_falla_motorica(informe.falla_de_motor)
  end

  def es_fallida?(auto, informe)
    return [informe.falla_de_motor, informe.falla_estetica, informe.falla_de_neumaticos].include?(InformeDeRevision::GRAVEDAD_GRAVE) if auto.anio < 1995

    false
  end

  def precio_base(auto)
    return 800_000 if auto.anio < 1995
    return 1_000_000 if auto.anio < 2010

    2_000_000
  end

  def porcentaje_por_falla_no_motorica(gravedad)
    PENALIDAD_NO_MOTORICA[gravedad]
  end

  def porcentaje_por_falla_motorica(gravedad)
    PENALIDAD_MOTORICA[gravedad]
  end
end

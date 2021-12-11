require_relative '../comandos/cotizacion_exitosa'
require_relative '../comandos/cotizacion_fallida'
require_relative './informe_de_revision'
class Cotizador
  PENALIDAD_POR_ESTETICA = {
    InformeDeRevision::GRAVEDAD_NULA => 0,
    InformeDeRevision::GRAVEDAD_LEVE => 0.03
  }.freeze

  def cotizar(publicacion, informe)
    return CotizacionFallida.new(publicacion) if es_fallida?(publicacion.auto, informe)

    precio = precio_base(publicacion.auto) - porcentaje_a_descontar(informe) * precio_base(publicacion.auto)
    CotizacionExitosa.new(publicacion, precio)
  end

  private

  def porcentaje_a_descontar(informe)
    penalidad_por_estetica(informe.falla_estetica) + penalidad_por_estetica(informe.falla_de_neumaticos)
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

  def penalidad_por_estetica(gravedad)
    PENALIDAD_POR_ESTETICA[gravedad]
  end
end

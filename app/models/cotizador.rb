require_relative '../comandos/cotizacion_exitosa'
require_relative '../comandos/cotizacion_fallida'

class Cotizador
  def cotizar(publicacion, informe)
    return CotizacionFallida.new(publicacion) if es_fallida?(publicacion.auto, informe)

    CotizacionExitosa.new(publicacion, precio_base(publicacion.auto))
  end

  private

  def es_fallida?(auto, informe)
    return [informe.falla_de_motor, informe.falla_estetica, informe.falla_de_neumaticos].include?(InformeDeRevision::GRAVEDAD_GRAVE) if auto.anio < 1995

    false
  end

  def precio_base(auto)
    return 800_000 if auto.anio < 1995
    return 1_000_000 if auto.anio < 2010

    2_000_000
  end
end

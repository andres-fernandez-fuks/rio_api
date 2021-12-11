require_relative '../comandos/cotizacion_exitosa'

class Cotizador
  def cotizar(publicacion, _informe)
    CotizacionExitosa.new(publicacion, precio_base(publicacion.auto))
  end

  private

  def precio_base(auto)
    return 800_000 if auto.anio < 1995
    return 1_000_000 if auto.anio < 2010

    2_000_000
  end
end

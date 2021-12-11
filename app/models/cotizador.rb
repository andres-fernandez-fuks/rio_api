class Cotizador
  def cotizar(auto, _informe)
    precio_base(auto)
  end

  private

  def precio_base(auto)
    return 800_000 if auto.anio < 1995
    return 1_000_000 if auto.anio < 2010

    2_000_000
  end
end

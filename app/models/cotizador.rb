class Cotizador
  def cotizar(auto, _informe)
    precio_base(auto)
  end

  private

  def precio_base(auto)
    return 800_000 if auto.anio < 1995

    1_000_000
  end
end

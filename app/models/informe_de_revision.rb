class InformeDeRevision
  GRAVEDAD_NULA = 0
  GRAVEDAD_LEVE = 1

  def initialize
    @falla_estetica = GRAVEDAD_NULA
    @falla_de_motor = GRAVEDAD_NULA
  end

  def con_falla_estetica(gravedad)
    @falla_estetica = gravedad
    self
  end

  def con_falla_de_motor(gravedad)
    @falla_de_motor = gravedad
    self
  end

  attr_reader :falla_estetica, :falla_de_motor

  def falla_de_neumaticos
    GRAVEDAD_NULA
  end
end

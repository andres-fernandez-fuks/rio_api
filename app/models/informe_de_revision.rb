require_relative './errors/errores'

class InformeDeRevision
  GRAVEDAD_NULA = 'Ninguna'.freeze
  GRAVEDAD_LEVE = 'Leve'.freeze
  GRAVEDAD_GRAVE = 'Grave'.freeze

  GRAVEDADES_VALIDAS = [GRAVEDAD_NULA, GRAVEDAD_LEVE, GRAVEDAD_GRAVE].freeze

  def initialize
    @falla_estetica = GRAVEDAD_NULA
    @falla_de_motor = GRAVEDAD_NULA
    @falla_de_neumaticos = GRAVEDAD_NULA
  end

  def con_falla_estetica(gravedad)
    raise GravedadInvalidaError unless GRAVEDADES_VALIDAS.include?(gravedad)

    @falla_estetica = gravedad
    self
  end

  def con_falla_de_motor(gravedad)
    @falla_de_motor = gravedad
    self
  end

  def con_falla_de_neumaticos(gravedad)
    @falla_de_neumaticos = gravedad
    self
  end

  attr_reader :falla_estetica, :falla_de_motor, :falla_de_neumaticos
end

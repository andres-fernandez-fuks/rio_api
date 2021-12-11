class GravedadInvalidaError < StandardError
  def initialize
    super('Gravedad de falla inválida')
  end
end

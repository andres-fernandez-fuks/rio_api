class PatenteYaRegistradaError < StandardError
  def initialize
    super('Esa patente ya se encuentra registrada en una publicación activa')
  end
end

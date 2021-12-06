class PublicacionVendidaError < StandardError
  def initialize
    super('La publicación ya fue vendida')
  end
end

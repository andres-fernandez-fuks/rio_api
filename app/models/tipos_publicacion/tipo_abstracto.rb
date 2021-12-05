class TipoAbstracto
  attr_reader :id

  def initialize(estado)
    @id = estado
  end

  def ==(other)
    @id == other.id
  end
end

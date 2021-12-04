class EstadoAbstracto
  attr_reader :id

  ID_ESTADO_REVISION = 1
  ID_ESTADO_ACTIVO = 2
  ID_ESTADO_VENDIDO = 3

  def initialize(estado)
    @id = estado
  end

  def ==(other)
    @id == other.id
  end
end

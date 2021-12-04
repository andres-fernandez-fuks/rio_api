class EstadoAbstracto
  attr_reader :id

  ID_ESTADO_REVISION = 1
  ID_ESTADO_COTIZADO = 2
  ID_ESTADO_ACTIVO = 3
  ID_ESTADO_VENDIDO = 4

  def initialize(estado)
    @id = estado
  end

  def ==(other)
    @id == other.id
  end
end

class EstadoCancelado < EstadoAbstracto
  ID_ESTADO_CANCELADO = 'Cancelado'.freeze
  def initialize
    super(ID_ESTADO_CANCELADO)
  end
end

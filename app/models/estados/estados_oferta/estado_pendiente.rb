class EstadoPendiente < EstadoAbstracto
  ID_ESTADO_PENDIENTE = 'Pendiente'.freeze
  def initialize
    super(ID_ESTADO_PENDIENTE)
  end
end

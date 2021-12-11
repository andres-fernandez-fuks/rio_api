class EstadoReservado < EstadoAbstracto
  ID_ESTADO_RESERVADO = 'Reservado'.freeze
  def initialize
    super(ID_ESTADO_RESERVADO)
  end
end

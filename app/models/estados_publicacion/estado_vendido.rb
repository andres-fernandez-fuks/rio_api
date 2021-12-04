class EstadoVendido < EstadoAbstracto
  ID_ESTADO_VENDIDO = 'Vendido'.freeze
  def initialize
    super(ID_ESTADO_VENDIDO)
  end
end

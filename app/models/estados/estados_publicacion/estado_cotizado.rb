class EstadoCotizado < EstadoAbstracto
  ID_ESTADO_COTIZADO = 'Cotizado'.freeze
  def initialize
    super(ID_ESTADO_COTIZADO)
  end
end

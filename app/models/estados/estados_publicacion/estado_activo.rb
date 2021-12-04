class EstadoActivo < EstadoAbstracto
  ID_ESTADO_ACTIVO = 'Activo'.freeze
  def initialize
    super(ID_ESTADO_ACTIVO)
  end
end

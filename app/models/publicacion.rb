class Publicacion
  attr_reader :precio, :usuario, :estado, :updated_on, :created_on
  attr_accessor :id

  ESTADO_REVISION = 0
  ESTADO_ACTIVO = 1
  ESTADO_VENDIDO = 2

  def initialize(precio, usuario, id = nil)
    @precio = precio
    @usuario = usuario
    @id = id
    @estado = ESTADO_REVISION
  end

  def activar
    @estado = ESTADO_ACTIVO
  end
end

class Publicacion
  attr_reader :precio, :usuario, :estado, :updated_on, :created_on
  attr_accessor :id

  PRECIO_DEFAULT = 70_000

  def initialize(precio, usuario, id = nil)
    @precio = precio
    @usuario = usuario
    @id = id
    @estado = EstadoRevision.new
  end

  def activar
    @estado = EstadoActivo.new
    @precio = PRECIO_DEFAULT
  end
end

class Publicacion
  attr_reader :precio, :usuario, :estado, :updated_on, :created_on
  attr_accessor :id
  
  def initialize(precio, usuario, id = nil)
    @precio = precio
    @usuario = usuario
    @id = id
    @estado = EstadoRevision.new
  end

  def activar
    @estado = EstadoActivo.new
  end

  def vendida
    @estado = EstadoVendido.new
  end
end

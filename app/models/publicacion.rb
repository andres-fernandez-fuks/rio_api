class Publicacion
  attr_reader :precio, :usuario, :updated_on, :created_on
  attr_accessor :id

  def initialize(precio, usuario, id = nil)
    @precio = precio
    @usuario = usuario
    @id = id
  end
end

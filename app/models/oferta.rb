class Oferta
  attr_reader :precio, :oferente, :id_publicacion, :updated_on, :created_on
  attr_accessor :id

  def initialize(precio, oferente, id_publicacion, id = nil)
    @id = id
    @precio = precio
    @oferente = oferente
    @id_publicacion = id_publicacion
  end
end

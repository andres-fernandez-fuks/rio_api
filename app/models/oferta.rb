class Oferta
  attr_reader :precio, :oferente, :publicacion, :updated_on, :created_on
  attr_accessor :id

  def initialize(precio, oferente, publicacion, id = nil)
    @id = id
    @precio = precio
    @oferente = oferente
    @publicacion = publicacion
  end

  def aceptar
    @publicacion.vendida
  end

  def fiubak?
    true
  end
end

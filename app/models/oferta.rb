class Oferta
  attr_reader :precio, :oferente, :publicacion, :updated_on, :created_on, :estado
  attr_accessor :id

  def initialize(precio, oferente, publicacion, id = nil)
    @id = id
    @precio = precio
    @oferente = oferente
    @publicacion = publicacion
    @estado = EstadoPendiente.new
  end

  def aceptar
    @publicacion.vendida
    @estado = EstadoAceptada.new
  end

  def fiubak?
    true
  end
end

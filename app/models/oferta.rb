class Oferta
  attr_reader :monto, :oferente, :publicacion, :updated_on, :created_on, :estado
  attr_accessor :id

  def initialize(monto, oferente, publicacion, id = nil)
    @id = id
    @monto = monto
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

  def establecer_estado(estado)
    @estado = estado
  end

  def rechazar
    @estado = EstadoRechazada.new
  end
end

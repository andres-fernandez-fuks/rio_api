class Oferta
  attr_reader :monto, :oferente, :publicacion, :updated_on, :created_on, :estado
  attr_accessor :id

  def initialize(monto, oferente, publicacion, id = nil)
    @id = id
    @monto = monto.to_f
    @oferente = oferente
    @publicacion = publicacion
    @estado = EstadoPendiente.new
  end

  def aceptar
    @estado = EstadoAceptada.new
  end

  def establecer_estado(estado)
    @estado = estado
  end

  def rechazar
    @estado = EstadoRechazada.new
  end

  def es_fiubak?
    oferente == UsuarioFiubak.new
  end

  def es_p2p?
    !es_fiubak?
  end
end

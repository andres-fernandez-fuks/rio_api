class PublicacionFiubak < Publicacion
  def initialize(precio, usuario, auto, id = nil)
    super(precio, usuario, auto, id)
    @estado = EstadoActivo.new
  end

  def tipo
    TipoFiubak.new
  end
end

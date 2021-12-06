class PublicacionP2P < Publicacion
  def initialize(precio, usuario, auto, id = nil)
    super(precio, usuario, auto, id)
    @estado = EstadoRevision.new
  end

  def tipo
    TipoP2P.new
  end
end

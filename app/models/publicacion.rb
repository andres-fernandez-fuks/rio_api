class Publicacion
  attr_reader :precio, :usuario, :estado, :auto, :updated_on, :created_on, :tipo
  attr_accessor :id

  def initialize(precio, usuario, auto, tipo = TipoP2P.new, id = nil)
    @precio = precio.to_f
    @usuario = usuario
    @auto = auto
    @tipo = tipo
    @id = id
    @estado = EstadoRevision.new
  end

  def activar
    @estado = EstadoActivo.new
  end

  def vendida
    @estado = EstadoVendido.new
  end

  def cotizada
    @estado = EstadoCotizado.new if @estado == EstadoRevision.new
  end
end

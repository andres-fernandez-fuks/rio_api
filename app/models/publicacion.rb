class Publicacion
  attr_reader :precio, :usuario, :estado, :auto, :updated_on, :created_on
  attr_accessor :id

  def initialize(precio, usuario, auto, id = nil)
    @precio = precio.to_f
    @usuario = usuario
    @auto = auto
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

  def cancelar
    @estado = EstadoCancelado.new
  end

  def reservar
    raise 'Subclass must implement'
  end
end

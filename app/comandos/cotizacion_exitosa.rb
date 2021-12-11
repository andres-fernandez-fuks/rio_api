require_relative './comando'

class CotizacionExitosa < Comando
  attr_reader :monto

  def initialize(publicacion, monto)
    super()
    @publicacion = publicacion
    @monto = monto
  end

  def ejecutar
    @publicacion.cotizada
    oferta = Oferta.new(@monto, usuario_fiubak, @publicacion)
    repo_de_ofertas.save(oferta)
    repo_de_publicaciones.save(@publicacion)
  end
end

class RealizarOferta
  def initialize(repo_ofertas)
    @repo_ofertas = repo_ofertas
  end

  def ejecutar(monto, oferente, publicacion)
    raise PublicacionVendidaError if publicacion.estado == EstadoVendido.new

    oferta = Oferta.new(monto, oferente, publicacion)
    @repo_ofertas.save(oferta)
    NotificadorDeOferta.new(oferta).notificar
    oferta
  end
end

class CotizacionExitosa
  attr_reader :monto

  def initialize(publicacion, monto, repo_ofertas, repo_publicaciones, repo_usuarios)
    @publicacion = publicacion
    @monto = monto
    @repo_ofertas = repo_ofertas
    @repo_publicaciones = repo_publicaciones
    @repo_usuarios = repo_usuarios
  end

  def ejecutar
    @publicacion.cotizada
    oferta = Oferta.new(@monto, usuario_fiubak, @publicacion)
    @repo_ofertas.save(oferta)
    @repo_publicaciones.save(@publicacion)
    NotificadorDeOferta.new(oferta).notificar
  end

  def exitosa?
    true
  end

  private

  def usuario_fiubak
    @repo_usuarios.buscar_usuario_fiubak
  end
end

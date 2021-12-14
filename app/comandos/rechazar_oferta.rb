class RechazarOferta
  def initialize(repo_publicaciones, repo_ofertas)
    @repo_publicaciones = repo_publicaciones
    @repo_ofertas = repo_ofertas
  end

  def ejecutar(oferta)
    publicacion = oferta.publicacion
    publicacion.activar
    oferta.rechazar
    @repo_publicaciones.save(publicacion)
    @repo_ofertas.save(oferta)
  end
end

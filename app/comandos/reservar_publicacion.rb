class ReservarPublicacion
  def initialize(repo_publicaciones)
    @repo_publicaciones = repo_publicaciones
  end

  def ejecutar(publicacion)
    publicacion.reservar
    @repo_publicaciones.save(publicacion)
  end
end

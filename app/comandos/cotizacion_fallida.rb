class CotizacionFallida
  def initialize(publicacion, repo_publicaciones)
    @publicacion = publicacion
    @repo_publicaciones = repo_publicaciones
  end

  def ejecutar
    @publicacion.cancelar
    @repo_publicaciones.save(@publicacion)
  end

  def exitosa?
    false
  end
end

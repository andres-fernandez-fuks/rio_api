class CotizarPublicacion < Comando
  def initialize(id_publicacion, informe)
    super()
    @id_publicacion = id_publicacion
    @informe = informe
  end

  def ejecutar
    publicacion = repo_de_publicaciones.find(@id_publicacion)
    publicacion.cotizada
    repo_de_publicaciones.save(publicacion)
  end
end

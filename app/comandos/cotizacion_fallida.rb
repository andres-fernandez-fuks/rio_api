class CotizacionFallida < Comando
  def initialize(publicacion)
    super()
    @publicacion = publicacion
  end

  def ejecutar
    @publicacion.cancelar
    repo_de_publicaciones.save(@publicacion)
  end
end

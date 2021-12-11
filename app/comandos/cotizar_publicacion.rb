class CotizarPublicacion < Comando
  def initialize(id_publicacion, informe)
    super()
    @id_publicacion = id_publicacion
    @informe = informe
  end

  def ejecutar
    publicacion = repo_de_publicaciones.find(@id_publicacion)
    cotizacion = Cotizador.new.cotizar(publicacion, @informe)
    cotizacion.ejecutar
  end
end

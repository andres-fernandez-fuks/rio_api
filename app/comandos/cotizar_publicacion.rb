class CotizarPublicacion < Comando
  attr_reader :cotizacion_exitosa

  def initialize(id_publicacion, informe)
    super()
    @id_publicacion = id_publicacion
    @informe = informe
    @cotizacion_exitosa = false
  end

  def ejecutar
    publicacion = repo_de_publicaciones.find(@id_publicacion)
    cotizacion = Cotizador.new.cotizar(publicacion, @informe)
    @cotizacion_exitosa = true if cotizacion.exitosa?
    cotizacion.ejecutar
  end
end

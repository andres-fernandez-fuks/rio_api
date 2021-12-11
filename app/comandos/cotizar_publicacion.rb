class CotizarPublicacion < Comando
  def initialize(id_publicacion, informe)
    super()
    @id_publicacion = id_publicacion
    @informe = informe
  end

  def ejecutar
    publicacion = repo_de_publicaciones.find(@id_publicacion)
    monto_cotizacion = Cotizador.new.cotizar(publicacion.auto, @informe)
    publicacion.cotizada
    oferta = Oferta.new(monto_cotizacion, usuario_fiubak, publicacion)
    repo_de_ofertas.save(oferta)
    repo_de_publicaciones.save(publicacion)
  end
end

class AceptarOferta
  def self.ejecutar(oferta)
    publicacion = oferta.publicacion
    publicacion.vendida if oferta.fiubak?
    guardar_cambios(oferta, publicacion)
  end

  def self.guardar_cambios(oferta, publicacion)
    Persistence::Repositories::RepositorioPublicaciones.new.save(publicacion)
    Persistence::Repositories::RepositorioOfertas.new.save(oferta)
  end
end

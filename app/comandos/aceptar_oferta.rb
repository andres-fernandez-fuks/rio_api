class AceptarOferta
  def ejecutar(oferta)
    publicacion = oferta.publicacion
    publicacion.vendida if oferta.fiubak?
    publicacion_nueva = Publicacion.new(publicacion.precio, fiubak)
    publicacion_nueva.activar
    guardar_cambios(oferta, publicacion, publicacion_nueva)
  end

  private

  def guardar_cambios(oferta, publicacion, publicacion_nueva)
    Persistence::Repositories::RepositorioPublicaciones.new.save(publicacion_nueva)
    Persistence::Repositories::RepositorioPublicaciones.new.save(publicacion)
    Persistence::Repositories::RepositorioOfertas.new.save(oferta)
  end

  def fiubak
    fiubak = Usuario.new('fiubak','fiubak','fiubak')
    Persistence::Repositories::RepositorioUsuarios.new.save(fiubak)
  end
end

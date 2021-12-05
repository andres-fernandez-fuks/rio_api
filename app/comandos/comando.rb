class Comando
  private

  def guardar_oferta(oferta)
    Persistence::Repositories::RepositorioOfertas.new.save(oferta)
  end

  def guardar_publicacion(publicacion)
    Persistence::Repositories::RepositorioPublicaciones.new.save(publicacion)
  end

  def guardar_usuario(usuario)
    Persistence::Repositories::RepositorioUsuarios.new.save(usuario)
  end
end

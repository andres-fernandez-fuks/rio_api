class Comando
  private

  def guardar_oferta(oferta)
    Persistence::Repositories::RepositorioOfertas.new.save(oferta)
  end

  def guardar_publicacion(publicacion)
    Persistence::Repositories::RepositorioPublicaciones.new.save(publicacion)
  end

  def guardar_auto(auto)
    Persistence::Repositories::RepositorioAutos.new.save(auto)
  end

  def guardar_usuario(usuario)
    Persistence::Repositories::RepositorioUsuarios.new.save(usuario)
  end

  def usuario_fiubak
    Persistence::Repositories::RepositorioUsuarios.new.buscar_usuario_fiubak
  end

  def repo_de_publicaciones
    Persistence::Repositories::RepositorioPublicaciones.new
  end

  def repo_de_ofertas
    Persistence::Repositories::RepositorioOfertas.new
  end
end

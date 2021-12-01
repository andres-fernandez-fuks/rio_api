WebTemplate::App.controllers :usuarios, :provides => [:json] do
  post :create, :map => '/publicaciones/:id_publicacion/informe_cotizacion' do
    publicacion = repo_publicaciones.find(params[:id_publicacion])
    unless publicacion
      status 404
      return
    end

    publicacion.fue_publicada
    usuario = Usuario.new(params_usuario[:nombre], params_usuario[:mail], params_usuario[:id_telegram])
    nuevo_usuario = repo_usuario.save(usuario)
    status 201
    usuario_a_json nuevo_usuario
  end

  post :create, :map => '/publicaciones' do
    usuario = repo_usuario.buscar_por_id_telegram(params_publicacion[:id_telegram])
    publicacion = Publicacion.new(params_publicacion[:precio], usuario)
    nueva_publicacion = repo_publicaciones.save(publicacion)
    status 201
    publicacion_a_json nueva_publicacion
  end
end

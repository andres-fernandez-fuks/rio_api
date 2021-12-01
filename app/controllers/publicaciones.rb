WebTemplate::App.controllers :usuarios, :provides => [:json] do
  post :create, :map => '/publicaciones/:id_publicacion/informe_cotizacion' do
    id_telegram = request.get_header('HTTP_ID_TELEGRAM') || request.get_header('ID_TELEGRAM')
    publicacion = repo_publicaciones.find(params[:id_publicacion])
    unless publicacion
      status 404
      return
    end

    id_usuario_publicacion = publicacion.usuario.id_telegram
    if id_telegram != id_usuario_publicacion
      status 403
      return
    end

    publicacion.activar
    if repo_publicaciones.save(publicacion)
      status 200
      publicacion_activada(publicacion)
      # deberia mandar un mensaje/mail al usuario informando
    else
      status 500
    end
  end

  post :create, :map => '/publicaciones' do
    begin
      usuario = repo_usuario.buscar_por_id_telegram(params_publicacion[:id_telegram])
      publicacion = Publicacion.new(params_publicacion[:precio], usuario)
      nueva_publicacion = repo_publicaciones.save(publicacion)
      status 201
      publicacion_a_json nueva_publicacion
    rescue StandardError => e
      status 400
      {error: e.message}.to_json
    end
  end

  get :show, :map => '/publicaciones/yo' do
    id_telegram = request.get_header('HTTP_ID_TELEGRAM') || request.get_header('ID_TELEGRAM')
    unless id_telegram
      status 400
      return
    end

    usuario = repo_usuario.buscar_por_id_telegram(id_telegram)
    publicaciones_de_usuario = repo_publicaciones.buscar_por_usuario(usuario.id)
    status 200
    listar_publicaciones(publicaciones_de_usuario)
  end
end

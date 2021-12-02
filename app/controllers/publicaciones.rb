WebTemplate::App.controllers :usuarios, :provides => [:json] do
  post :create, :map => '/publicaciones/:id_publicacion/informe_cotizacion' do
    publicacion = repo_publicaciones.find(params[:id_publicacion])
    unless publicacion
      status 404
      return
    end
    precio = params_publicacion[:precio]
    usuario = Usuario.new('fiubak', 'fiubak', 'fiubak')
    usuario = repo_usuario.save(usuario)
    oferta = repo_ofertas.save(Oferta.new(precio, usuario, publicacion))
    if oferta
      status 200
      oferta_creada(oferta)
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
    if !id_telegram || id_telegram == ''
      status 400
      return
    end

    usuario = repo_usuario.buscar_por_id_telegram(id_telegram)

    unless usuario
      status 404
      return
    end

    publicaciones_de_usuario = repo_publicaciones.buscar_por_usuario(usuario.id)
    status 200
    listar_publicaciones(publicaciones_de_usuario)
  end

  get :show, :map => '/publicaciones' do
    publicaciones = repo_publicaciones.buscar_activas
    status 200
    listar_publicaciones(publicaciones)
  end

  post :create, :map => '/_publicacionesActivas' do
    begin
      usuario_nuevo = Usuario.new('Manu', 'm@asd.com','123')
      usuario = repo_usuario.save(usuario_nuevo)
      publicacion = Publicacion.new(454545, usuario)
      publicacion.activar
      nueva_publicacion = repo_publicaciones.save(publicacion)
      status 201
      publicacion_a_json nueva_publicacion
    rescue StandardError => e
      status 400
      {error: e.message}.to_json
    end
  end
end

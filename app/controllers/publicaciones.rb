WebTemplate::App.controllers :usuarios, :provides => [:json] do
  post :create, :map => '/publicaciones/:id_publicacion/informe_cotizacion' do
    publicacion = repo_publicaciones.find(params[:id_publicacion])
    unless publicacion
      status 404
      return
    end

    publicacion.activar
    if repo_publicaciones.save(publicacion)
      status 200
      publicacion_activada(publicacion)
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
end

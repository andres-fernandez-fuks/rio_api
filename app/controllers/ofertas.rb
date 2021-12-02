WebTemplate::App.controllers :ofertas, :provides => [:json] do
  patch :create, :map => '/ofertas/:id_publicacion' do
    mensaje = params_oferta[:estado]
    if mensaje == 'aceptada'
      oferta = repo_ofertas.find(params[:id_publicacion])
      unless publicacion
        status 404
        return
      end
      oferta.aceptar
      if repo_publicaciones.save(oferta)
        status 204
        publicacion_activada(publicacion)
      else
        status 500
      end
    end
  end

  get :show, :map => '/ofertas/:id_publicacion' do
    id_telegram = request.get_header('HTTP_ID_TELEGRAM') || request.get_header('ID_TELEGRAM')
    unless id_telegram
      status 400
      return
    end

    publicacion = repo_publicaciones.find(params[:id_publicacion])
    usuario = publicacion.usuario

    if usuario.id_telegram != id_telegram
      status 403
      return
    end

    repo_ofertas
      .usuario = repo_usuario.buscar_por_id_telegram(id_telegram)
    ofertas_de_usuario = repo_ofertas.buscar_por_oferente(usuario.id)
    status 200
    listar_ofertas(ofertas_de_usuario)
  end
end

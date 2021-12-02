WebTemplate::App.controllers :ofertas, :provides => [:json] do
  patch :create, :map => '/ofertas/:id_oferta' do
    mensaje = params_oferta[:estado]
    if mensaje == 'aceptada'
      oferta = repo_ofertas.find(params[:id_oferta])
      unless oferta
        status 404
        return
      end
      oferta.aceptar

      if repo_ofertas.save(oferta)
        status 204
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

    ofertas = repo_ofertas.buscar_por_publicacion(publicacion.id)
    status 200
    listar_ofertas(ofertas)
  end
end

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
end

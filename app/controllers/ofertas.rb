WebTemplate::App.controllers :ofertas, :provides => [:json] do
  patch :create, :map => '/ofertas/:id_oferta' do # rubocop:disable Metrics/BlockLength
    mensaje = params_oferta[:estado]
    begin
      oferta = repo_ofertas.find(params[:id_oferta])
    rescue ObjectNotFound
      status 404
      error_oferta_no_encontrada
    end
    case mensaje.downcase
    when EstadoAceptada.new.id.downcase
      begin
        aceptar_oferta(oferta)
        status 200
        oferta_a_json(oferta)
      rescue StandardError => e
        status 500
        {error: e.message}.to_json
      end
    when EstadoRechazada.new.id.downcase
      begin
        rechazar_oferta(oferta)
        status 200
        oferta_a_json(oferta)
      rescue StandardError => e
        status 500
        {error: e.message}.to_json
      end
    else
      status 400
    end
  end

  post :show, :map => '/publicaciones/:id_publicacion/oferta' do
    id_telegram = request.get_header('HTTP_ID_TELEGRAM') || request.get_header('ID_TELEGRAM')
    unless id_telegram
      status 400
      return
    end

    usuario = repo_usuarios.find(id_telegram)
    unless usuario
      status 401
      return
    end

    ofertas = repo_ofertas.buscar_por_publicacion(publicacion.id)
    status 200
    listar_ofertas(ofertas)
  end
end

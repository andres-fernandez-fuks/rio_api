require_relative '../comandos/cotizar_publicacion'
require_relative '../comandos/registrar_auto'

WebTemplate::App.controllers :usuarios, :provides => [:json] do
  post :create, :map => '/publicaciones/:id_publicacion/informe_cotizacion' do
    publicacion = repo_publicaciones.find(params[:id_publicacion])
    unless publicacion
      status 404
      return
    end
    informe = parsear_informe(params_publicacion)
    comando = CotizarPublicacion.new(publicacion.id, informe)
    comando.ejecutar
    print(publicacion.mail_usuario)
    begin
      EnviadorDeMails.enviar_informe_a(publicacion.mail_usuario, formatear_para_mail(informe))
    rescue StandardError
      logger.info 'API_FIUBAK: Error al enviar email'
    end
    oferta = repo_ofertas.buscar_por_publicacion(publicacion.id)[0]
    if oferta
      status 200
      oferta_a_json(oferta)
    else
      status 204
    end
  end

  post :create, :map => '/publicaciones' do
    begin
      usuario = repo_usuario.buscar_por_id_telegram(params_publicacion[:id_telegram])
      unless usuario
        status 401
        return
      end
      auto = parsear_auto(params_publicacion)
      publicacion = parsear_publicacion(params_publicacion[:precio], usuario, auto)
      RegistrarAuto.new.ejecutar(publicacion)

      status 201
      publicacion_a_json publicacion
    rescue PatenteYaRegistradaError
      status 409
    rescue ObjectNotFound
      status 400
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
    listar_mis_publicaciones(publicaciones_de_usuario)
  end

  get :show, :map => '/publicaciones' do
    publicaciones = repo_publicaciones.buscar_activas
    status 200
    listar_publicaciones(publicaciones)
  end

  get :show, :map => '/publicaciones/:id_publicacion/ofertas' do
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

  post :create, :map => '/publicaciones/:id_publicacion/reservas' do
    begin
      publicacion = repo_publicaciones.find(params[:id_publicacion])
      reservar(publicacion)
      status 200
    rescue ObjectNotFound => e
      status 404
      {:error => e.message}.to_json
    rescue StandardError => e
      status 500
      {:error => e.message}.to_json
    end
  end
end

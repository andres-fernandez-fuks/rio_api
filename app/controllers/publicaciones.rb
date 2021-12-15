require_relative '../comandos/cotizar_publicacion'
require_relative '../comandos/registrar_auto'
require_relative '../logger/logger'

WebTemplate::App.controllers :usuarios, :provides => [:json] do
  post :create, :map => '/publicaciones/:id_publicacion/informe_cotizacion' do
    begin
      publicacion = repo_publicaciones.find(params[:id_publicacion])
      informe = parsear_informe(params_publicacion)
      comando = CotizarPublicacion.new(publicacion.id, informe, repo_publicaciones)
      comando.ejecutar
    rescue ObjectNotFound => e
      Logger.log('info', "Publicacion con id: #{params[:id_publicacion]} no fue encontrada")
      status 404
      {error: e.message}.to_json
    rescue StandardError => e
      status 500
      {error: e.message}.to_json
    end
    begin
      EnviadorDeMails.enviar_informe_a(publicacion.mail_usuario, formatear_para_mail(informe))
    rescue StandardError
      Logger.log('info', 'Error al enviar email, posiblemente se alcanzó el maximo de envios diarios')
    end
    if comando.cotizacion_exitosa
      oferta = repo_ofertas.buscar_por_publicacion(publicacion.id)[0]
      status 200
      oferta_a_json(oferta)
    else
      status 204
    end
  end

  post :create, :map => '/publicaciones' do
    begin
      usuario = repo_usuarios.buscar_por_id_telegram(params_publicacion[:id_telegram])
      auto = parsear_auto(params_publicacion)
      publicacion = parsear_publicacion(params_publicacion[:precio], usuario, auto)
      RegistrarAuto.new(repo_publicaciones, repo_autos).ejecutar(publicacion)

      status 201
      publicacion_a_json publicacion
    rescue PatenteYaRegistradaError
      status 409
      Logger.log('info', 'Publicacion de auto con patente ya registrada')
    rescue ObjectNotFound
      status 400
      Logger.log('info', 'Error al buscar auto o publicacion')
    end
  end

  get :show, :map => '/publicaciones/yo' do
    id_telegram = request.get_header('HTTP_ID_TELEGRAM') || request.get_header('ID_TELEGRAM')
    if !id_telegram || id_telegram == ''
      status 400
      Logger.log('info', 'No se ha enviado el header con ID de telegram')
      return
    end
    begin
      usuario = repo_usuarios.buscar_por_id_telegram(id_telegram)
      publicaciones_de_usuario = repo_publicaciones.buscar_por_usuario(usuario.id)
      status 200
      listar_mis_publicaciones(publicaciones_de_usuario)
    rescue ObjectNotFound
      status 404
      Logger.log('info', "Usuario con id: #{id_telegram} no fue encontrado")
    end
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
      Logger.log('info', 'No se ha enviado el header con ID de telegram')
      return
    end
    publicacion = repo_publicaciones.find(params[:id_publicacion])
    usuario = publicacion.usuario

    if usuario.id_telegram != id_telegram
      status 403
      Logger.log('info', 'No coinciden el id de usuario con el usuario de la base de datos')
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
      Logger.log('info', "La publicacion con id: #{params[:id_publicacion]} no fue encontrada")
      {:error => e.message}.to_json
    rescue StandardError => e
      status 500
      Logger.log('fatal', "Error al procesar reserva. Error: #{e.message}")
      {:error => e.message}.to_json
    end
  end
end

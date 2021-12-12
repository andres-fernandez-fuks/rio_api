require_relative '../logger/logger'

WebTemplate::App.controllers :ofertas, :provides => [:json] do
  patch :create, :map => '/ofertas/:id_oferta' do # rubocop:disable Metrics/BlockLength
    mensaje = params_oferta[:estado]
    begin
      oferta = repo_ofertas.find(params[:id_oferta])
    rescue ObjectNotFound
      status 404
      Logger.log('info', "Oferta con id: #{params[:id_oferta]} no encontrada")
      error_oferta_no_encontrada
    end
    case mensaje.downcase
    when EstadoAceptada.new.id.downcase
      begin
        oferta_aceptada = aceptar_oferta(oferta)
        id_publicacion_fiubak = oferta_aceptada.id_publicacion_fiubak
        status 200
        oferta_a_json(oferta, incluir_contacto: true, id_publicacion_fiubak: id_publicacion_fiubak)
      rescue PublicacionVendidaError => e
        status 400
        Logger.log('info', "Oferta con id: #{params[:id_oferta]} pertenece a una oferta vencida")
        { error: e.message }.to_json
      rescue StandardError => e
        Logger.log('fatal', "Oferta con id: #{params[:id_oferta]} ha lanzado el error: #{e.message}")
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
        Logger.log('fatal', "Oferta con id: #{params[:id_oferta]} ha lanzado el error: #{e.message}")
        {error: e.message}.to_json
      end
    else
      status 400
    end
  end

  # rubocop: disable Metrics/BlockLength
  post :show, :map => '/publicaciones/:id_publicacion/oferta' do
    id_telegram = request.get_header('HTTP_ID_TELEGRAM') || request.get_header('ID_TELEGRAM')
    precio = params_oferta[:precio]
    id_publicacion = params[:id_publicacion]
    unless id_telegram && precio && id_publicacion
      Logger.log('fatal', "Publicacion con id: #{id_publicacion} tiene parametros faltantes")
      status 400
      return
    end

    begin
      usuario = repo_usuario.buscar_por_id_telegram(id_telegram)
    rescue ObjectNotFound
      Logger.log('info', "Usuario con id: #{id_telegram} de la publicacion con id: #{id_publicacion} no fue encontrado")
      status 401
      return
    end

    begin
      publicacion = repo_publicaciones.find(id_publicacion)
    rescue ObjectNotFound
      status 404
      Logger.log('info', "Publicacion con id: #{id_publicacion} no fue encontrada")
      return
    end
    begin
      oferta = realizar_oferta(precio, usuario, publicacion)
      status 201
      oferta_a_json(oferta)
    rescue PublicacionVendidaError => e
      status 409
      Logger.log('info', "Publicacion con id: #{id_publicacion} ya fue vendida")
      {error: e.message}.to_json
    end
  end
end
# rubocop: enable Metrics/BlockLength

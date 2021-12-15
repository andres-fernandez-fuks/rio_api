require_relative '../comandos/registrar_usuario'
require_relative '../models/errors/errores'
require_relative '../logger/logger'

WebTemplate::App.controllers :usuarios, :provides => [:json] do
  post :create, :map => '/usuarios' do
    begin
      usuario = Usuario.new(params_usuario[:nombre], params_usuario[:mail], params_usuario[:id_telegram])
      nuevo_usuario = RegistrarUsuario.new(repo_usuarios).ejecutar(usuario)
      status 201
      usuario_a_json nuevo_usuario
    rescue MailDeUsuarioEnUsoError
      status 409
      Logger.log('info', "El usuario con mail: #{params_usuario[:mail]} ya se encuentra registrado")
      error_mail_ya_registrado
    end
  end

  get :show, :map => '/usuarios/yo' do
    id_telegram = request.get_header('HTTP_ID_TELEGRAM') || request.get_header('ID_TELEGRAM')
    unless id_telegram
      status 400
      Logger.log('info', 'No se ha incluido un header con ID de telegram en la request')
      return
    end

    usuario = repo_usuarios.buscar_por_id_telegram(id_telegram)
    if usuario.nil?
      status 404
      Logger.log('info', "El usuario con id de telegram: #{id_telegram} no fue encontrado")
      error_usuario_no_encontrado
    else
      status 200
      usuario_a_json usuario
    end
  end
end

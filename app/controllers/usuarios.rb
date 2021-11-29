WebTemplate::App.controllers :usuarios, :provides => [:json] do
  post :create, :map => '/usuarios' do
    usuario = Usuario.new(params_usuario[:nombre], params_usuario[:mail], params_usuario[:id_telegram])
    nuevo_usuario = repo_usuario.save(usuario)
    status 201
    usuario_a_json nuevo_usuario
  end

  get :show, :map => '/usuarios/yo' do
    id_telegram = request.get_header('HTTP_ID_TELEGRAM')
    unless id_telegram
      status 400
      return
    end

    usuario = repo_usuario.buscar_por_id_telegram(id_telegram)
    if usuario
      status 200
      usuario_a_json usuario
    else
      status 404
      error_usuario_no_encontrado
    end
  end
end

WebTemplate::App.controllers :usuarios, :provides => [:json] do
  post :create, :map => '/usuarios' do
    usuario = Usuario.new(params_ususario[:nombre], params_ususario[:mail], params_ususario[:id_telegram])
    nuevo_usuario = repo_usuario.save(usuario)
    status 201
    usuario_a_json nuevo_usuario
  end
end

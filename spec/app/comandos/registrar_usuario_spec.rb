require 'spec_helper'
require_relative '../../../app/comandos/registrar_usuario'
require_relative '../../../app/models/errors/errores'

describe RegistrarUsuario do
  let(:usuario) {Usuario.new( 'nombre_test', 'test123@gmail.com', '12398123')}
  let(:repo_usuarios) {Persistence::Repositories::RepositorioUsuarios.new}
  before(:each) do
    repo_usuarios.delete_all
  end

  it 'Lo guarda correctamente' do
    RegistrarUsuario.new(repo_usuarios).ejecutar(usuario)
    expect(repo_usuarios.all.length).to eq 1
  end

  it 'No lo guarda si ya hay otro con ese mismo mail' do
    RegistrarUsuario.new(repo_usuarios).ejecutar(usuario)
    usuario_mismo_mail = Usuario.new( 'nombre_test_2', 'test123@gmail.com', '98765432')
    expect{RegistrarUsuario.new(repo_usuarios).ejecutar(usuario_mismo_mail)}.to raise_error(MailDeUsuarioEnUsoError)
    expect(repo_usuarios.all.length).to eq 1
  end
end

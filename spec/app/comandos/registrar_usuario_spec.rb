require 'spec_helper'
require_relative '../../../app/comandos/registrar_usuario'

describe RegistrarUsuario do
  let(:usuario) {Usuario.new( 'nombre_test', 'test123@gmail.com', '12398123')}
  before(:each) do
    Persistence::Repositories::RepositorioUsuarios.new.delete_all
  end

  it 'Lo guarda correctamente' do
    RegistrarUsuario.new.ejecutar(usuario)
    expect(Persistence::Repositories::RepositorioUsuarios.new.all.length).to eq 1
  end

  xit 'No lo guarda si ya hay otro con ese mismo mail' do
    RegistrarUsuario.new.ejecutar(usuario)
    usuario_mismo_mail = Usuario.new( 'nombre_test_2', 'test123@gmail.com', '98765432')
    RegistrarUsuario.new.ejecutar(usuario_mismo_mail)
    expect(Persistence::Repositories::RepositorioUsuarios.new.all.length).to eq 1
  end
end

require 'spec_helper'
require_relative '../../../app/comandos/reservar_publicacion'
require_relative '../../../app/models/errors/errores'

describe ReservarPublicacion do
  let(:repo_publicaciones) {Persistence::Repositories::RepositorioPublicaciones.new}
  let(:repo_usuarios) {Persistence::Repositories::RepositorioUsuarios.new}
  let(:repo_autos) {Persistence::Repositories::RepositorioAutos.new}

  let(:usuario) {
    usuario = Usuario.new( 'nombre_test', 'test123@gmail.com', '12398123')
    repo_usuarios.save(usuario)
  }
  let(:auto) {
    auto = Auto.new("AAA000", "FORD", "AMAROK", 2019, 1)
    repo_autos.save(auto)

  }
  let(:auto2) {
    auto = Auto.new("BBB111", "Che", "AMAROK", 2020, 2)
    repo_autos.save(auto)
  }
  let(:publicacion_p2p) {
    publicacion_p2p = PublicacionP2P.new(200000, usuario, auto)
    publicacion_p2p.activar
    repo_publicaciones.save(publicacion_p2p)
  }
  let(:publicacion_fiubak) {
    publicacion_fiubak = PublicacionFiubak.new(200000, usuario, auto2)
    publicacion_fiubak.activar
    repo_publicaciones.save(publicacion_fiubak)
  }
  it 'si es de fiubak la reserva correctamente' do
    described_class.new(repo_publicaciones).ejecutar(publicacion_fiubak)
    expect(repo_publicaciones.find(publicacion_fiubak.id).estado).to eq EstadoReservado.new
  end

  it 'si es P2P levanta un error y no guarda nada' do
    expect{described_class.new(repo_publicaciones).ejecutar(publicacion_p2p)}.to raise_error(PublicacionNoReservableError)
    expect(repo_publicaciones.find(publicacion_p2p.id).estado).to eq EstadoActivo.new
  end
end

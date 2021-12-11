require 'spec_helper'
require_relative '../../../app/comandos/reservar_publicacion'
require_relative '../../../app/models/errors/errores'

describe ReservarPublicacion do
  let(:usuario) {
    usuario = Usuario.new( 'nombre_test', 'test123@gmail.com', '12398123')
    Persistence::Repositories::RepositorioUsuarios.new.save(usuario)
  }
  let(:auto) {
    auto = Auto.new("AAA000", "FORD", "AMAROK", 2019, 1)
    Persistence::Repositories::RepositorioAutos.new.save(auto)

  }
  let(:auto2) {
    auto = Auto.new("BBB111", "Che", "AMAROK", 2020, 2)
    Persistence::Repositories::RepositorioAutos.new.save(auto)
  }
  let(:publicacion_p2p) {
    publicacion_p2p = PublicacionP2P.new(200000, usuario, auto)
    Persistence::Repositories::RepositorioPublicaciones.new.save(publicacion_p2p)
  }
  let(:publicacion_fiubak) {
    publicacion_fiubak = PublicacionFiubak.new(200000, usuario, auto2)
    Persistence::Repositories::RepositorioPublicaciones.new.save(publicacion_fiubak)
  }
  before(:each){
    publicacion_p2p.activar
    publicacion_fiubak.activar
  }

  it 'si es de fiubak la reserva correctamente' do
    described_class.new.ejecutar(publicacion_fiubak)
    expect(Persistence::Repositories::RepositorioPublicaciones.new.find(publicacion_fiubak.id).estado).to eq EstadoReservado.new
  end

  xit 'si es P2P levanta un error y no guarda nada' do

  end
end

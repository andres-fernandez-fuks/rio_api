require 'spec_helper'
require_relative '../../../app/comandos/registrar_auto'
require_relative '../../../app/models/errors/errores'

describe RegistrarAuto do
  let(:patente_1) {'AAA000'}
  let(:patente_2) {'AAA111'}
  let(:auto_1) {Auto.new( patente_1, 'Toyota', 'Clio', 2018)}
  let(:auto_2) {Auto.new( patente_2, 'Toyota', 'Clio', 2018)}
  let(:usuario) {Usuario.new('fulanito', 'fulanito@gmail.com', '123')}
  let(:publicacion_1) {PublicacionP2P.new(10000, usuario, auto_1)}
  let(:publicacion_2) {PublicacionP2P.new(10000, usuario, auto_1)}
  let(:repo_publicaciones) {Persistence::Repositories::RepositorioPublicaciones.new}
  let(:repo_autos) {Persistence::Repositories::RepositorioAutos.new}

  before(:each) do
    Persistence::Repositories::RepositorioPublicaciones.new.delete_all
    Persistence::Repositories::RepositorioUsuarios.new.delete_all
    Persistence::Repositories::RepositorioAutos.new.delete_all
    Persistence::Repositories::RepositorioAutos.new.save(auto_1)
    Persistence::Repositories::RepositorioUsuarios.new.save(usuario)
  end

  it 'Lo guarda correctamente' do
    RegistrarAuto.new(repo_publicaciones, repo_autos).ejecutar(publicacion_1)
    expect(Persistence::Repositories::RepositorioPublicaciones.new.all.length).to eq 1
  end

  it 'No lo guarda si ya hay otra publicación activa con un auto de la misma patente' do
    RegistrarAuto.new(repo_publicaciones, repo_autos).ejecutar(publicacion_1)
    expect{RegistrarAuto.new(repo_publicaciones, repo_autos).ejecutar(publicacion_1)}.to raise_error(PatenteYaRegistradaError)
    expect(Persistence::Repositories::RepositorioUsuarios.new.all.length).to eq 1
  end

  it 'Lo guarda si ya hay otra publicación NO activa con un auto de la misma patente' do
    publicacion_guardada = RegistrarAuto.new(repo_publicaciones, repo_autos).ejecutar(publicacion_1)
    publicacion_guardada.vendida
    Persistence::Repositories::RepositorioPublicaciones.new.save(publicacion_guardada)
    RegistrarAuto.new(repo_publicaciones, repo_autos).ejecutar(publicacion_2)
    expect(Persistence::Repositories::RepositorioPublicaciones.new.all.length).to eq 2
  end
end

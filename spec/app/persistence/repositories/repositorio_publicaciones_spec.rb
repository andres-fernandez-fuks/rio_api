require 'spec_helper'
require 'integration_helper'
describe Persistence::Repositories::RepositorioPublicaciones do
  let(:repositorio) { described_class.new }
  let(:patente) {'AAA000'}
  let(:auto) {
    auto = Auto.new(patente, "FORD", "AMAROK", 2019)
    Persistence::Repositories::RepositorioAutos.new.save(auto)
  }
  let(:usuario) {
    usuario = Usuario.new("Juan", "J@asd.com", "123", 123)
    Persistence::Repositories::RepositorioUsuarios.new.save(usuario)
  }
  let(:usuario_fiubak) {
    usuario_fiubak = Usuario.new("fiubak", "fiubak@fiubak.com", "fiubak", 001)
    Persistence::Repositories::RepositorioUsuarios.new.save(usuario_fiubak)
  }
  let(:publicacion) { PublicacionP2P.new(30303, usuario, auto)}
  let(:publicacion_2) { PublicacionP2P.new(10000, usuario, auto)}
  let(:publicacion_fiubak) { PublicacionFiubak.new(1000, usuario_fiubak, auto)}
  before(:each) do
    repositorio.delete_all
  end

  context 'Guardado de publicación' do
    it 'guardar una publicación nueva la guarda correctamente' do
      id = repositorio.save(publicacion).id
      publicacion = repositorio.find(id)
      expect(publicacion.precio).to eq 30303
      expect(publicacion.usuario).to eq usuario
      expect(publicacion.estado).to eq EstadoRevision.new
    end

    it 'guardar una publicacion activa se guarda con el estado correcto' do
      publicacion.activar
      id = repositorio.save(publicacion).id
      publicacion = repositorio.find(id)
      expect(publicacion.estado).to eq EstadoActivo.new
    end

    it 'guardar una publicacion vendida se guarda con el estado correcto' do
      publicacion.vendida
      id = repositorio.save(publicacion).id
      publicacion = repositorio.find(id)
      expect(publicacion.estado).to eq EstadoVendido.new
    end

    it 'una publicacion cancelada se guarda y carga con estado correcto' do
      publicacion.cancelar
      id = repositorio.save(publicacion).id
      publicacion = repositorio.find(id)
      expect(publicacion.estado).to eq EstadoCancelado.new
    end

    it 'una publicacion p2p se guarda con el tipo correcto' do
      id_publicacion_p2p = repositorio.save(publicacion).id
      publicacion = repositorio.find(id_publicacion_p2p)
      expect(publicacion.tipo).to eq TipoP2P.new
    end


    it 'una publicacion de fiubak se guarda con el tipo correcto' do
      id_publicacion_fiubak = repositorio.save(publicacion_fiubak).id
      publicacion_fiubak = repositorio.find(id_publicacion_fiubak)
      expect(publicacion_fiubak.tipo).to eq TipoFiubak.new
    end
  end

  context 'Listar publicaciones activas' do
    it 'Si no existe ninguna, listar publicaciones activas devuelve vacío' do
      repositorio.delete_all
      expect(repositorio.buscar_activas.length).to eq 0
    end

    it 'si existe una publicacion activa, al listar activas se devuelve correctamente' do
      publicacion = PublicacionP2P.new(30, usuario, auto)
      publicacion.activar
      repositorio.save(publicacion)
      expect(repositorio.buscar_activas.length).to eq 1
    end
  end

  it 'consultar una publicacion de un usuario con una publicación debería traer los datos correctos' do
    repositorio.save(publicacion)
    publicaciones = repositorio.buscar_por_usuario(usuario.id)
    expect(publicaciones.length).to eq 1
    publicacion = publicaciones[0]
    expect(publicacion.precio).to eq 30303
    expect(publicacion.usuario).to eq usuario
  end

  it 'consultar una publicacion de un usuario sin publicaciones debería traer una lista vacía' do
    publicaciones = repositorio.buscar_por_usuario(usuario.id)
    expect(publicaciones.length).to eq 0
  end

  it 'consultar una publicacion de un usuario con dos publicaciones debería devolver 2 publicaciones' do
    repositorio.save(publicacion)
    repositorio.save(publicacion_2)
    publicaciones = repositorio.buscar_por_usuario(usuario.id)
    expect(publicaciones.length).to eq 2
  end

  context 'Consulta de publicaciones por estado y patente' do
    let(:patente) {'AAA000'}
    let(:estado_activo) {'Activo'}
    it 'si no existe ninguna publicación, la consulta devuelve vacía' do
      repositorio.delete_all
      expect(repositorio.buscar_por_patente_y_estado(patente, estado_activo).length).to eq 0
    end
  end

  let(:estado_revision) {'Revision'}

  it 'si existe una publicación con el estado por el que consulto y esa patente, la devuelve correctamente' do
    repositorio.save(publicacion)
    publicaciones = repositorio.buscar_por_patente_y_estado(patente, estado_revision)
    expect(publicaciones.length).to eq 1
    publicacion = publicaciones[0]
    expect(publicacion.precio).to eq 30303
    expect(publicacion.usuario).to eq usuario
    expect(publicacion.estado).to eq EstadoRevision.new
  end

  let(:estado_activo) {'Activo'}
  it 'si existe una publicación por un estado diferente al que consulto y esa patente, la consulta devuelve vacía' do
    repositorio.save(publicacion)
    expect(repositorio.buscar_por_patente_y_estado(patente, estado_activo).length).to eq 0
  end

  let(:otra_patente) {'ABC012'}
  it 'si existe una publicación por el estado que consulto pero por otra patente, la consulta devuelve vacía' do
    repositorio.save(publicacion)
    expect(repositorio.buscar_por_patente_y_estado(otra_patente, estado_revision).length).to eq 0
  end
end


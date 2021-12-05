require 'spec_helper'
require 'integration_helper'
describe Persistence::Repositories::RepositorioPublicaciones do
  let(:repositorio) { described_class.new }
  let(:auto) {
    auto = Auto.new("AAA000", "FORD", "AMAROK", 2019)
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
  let(:publicacion) { Publicacion.new(30303, usuario, auto, TipoP2P.new)}
  let(:publicacion_2) { Publicacion.new(10000, usuario, auto)}
  let(:publicacion_fiubak) { Publicacion.new(1000, usuario_fiubak, auto, TipoFiubak.new)}
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
      publicacion = Publicacion.new(30, usuario, auto)
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
end


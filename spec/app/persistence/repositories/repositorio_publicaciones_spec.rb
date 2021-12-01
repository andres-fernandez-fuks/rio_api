require 'spec_helper'

describe Persistence::Repositories::RepositorioPublicaciones do
  let(:repositorio) { described_class.new }
  let(:usuario) {
    usuario = Usuario.new("Juan", "J@asd.com", "123", 123)
    Persistence::Repositories::RepositorioUsuarios.new.save(usuario)
  }
  let(:publicacion) { Publicacion.new(30303, usuario)}
  before(:each) do
    repositorio.delete_all
  end

  context 'Guardado de publicación' do
    it 'guardar una publicación nueva la guarda correctamente' do
      id = repositorio.save(publicacion).id
      publicacion = repositorio.find(id)
      expect(publicacion.precio).to eq 30303
      expect(publicacion.usuario).to eq usuario
      expect(publicacion.estado).to eq ESTADO_REVISION
    end

    it 'guardar una publicacion activa se guarda con el estado correcto' do
      publicacion.activar
      id = repositorio.save(publicacion).id
      publicacion = repositorio.find(id)
      expect(publicacion.estado).to eq ESTADO_ACTIVO
    end
  end

  context 'Listar publicaciones activas' do
    it 'Si no existe ninguna, listar publicaciones activas devuelve vacío' do
      repositorio.delete_all
      expect(repositorio.buscar_activas.length).to eq 0
    end

    xit 'si existe una publicacion activa, al listar activas se devuelve correctamente' do
      publicacion = Publicacion.new(30, usuario)
      publicacion.activar
      repositorio.save(publicacion)
      expect(repositorio.buscar_activas.length).to eq 1
    end
  end
end

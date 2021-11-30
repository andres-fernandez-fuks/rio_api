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
      end
  end
end

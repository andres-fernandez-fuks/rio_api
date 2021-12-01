require 'spec_helper'

describe Persistence::Repositories::RepositorioOfertas do
  let(:repositorio) { described_class.new }
  let(:usuario) {
    usuario = Usuario.new("Juan", "J@asd.com", "123", 123)
    Persistence::Repositories::RepositorioUsuarios.new.save(usuario)
  }
  let(:publicacion) {
    publicacion = Publicacion.new(100, usuario, 1)
    Persistence::Repositories::RepositorioPublicaciones.new.save(publicacion)
  }
  let(:oferta) { Oferta.new(100, usuario, publicacion)}
  before(:each) do
    repositorio.delete_all
  end

  context 'Guardado de oferta' do
    it 'guardar una oferta nueva la guarda correctamente' do
      id = repositorio.save(oferta).id
      oferta = repositorio.find(id)
      expect(oferta.precio).to eq 100
      expect(oferta.oferente.id_telegram).to eq usuario.id_telegram
      expect(oferta.publicacion.id).to eq publicacion.id
    end
  end
end

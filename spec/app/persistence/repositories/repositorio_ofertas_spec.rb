require 'spec_helper'
require 'integration_helper'
describe Persistence::Repositories::RepositorioOfertas do
  let(:repositorio) { described_class.new }
  let(:auto) {
    auto = Auto.new("AAA000", "FORD", "AMAROK", 2019)
    Persistence::Repositories::RepositorioAutos.new.save(auto)
  }
  let(:usuario) {
    usuario = Usuario.new("Juan", "J@asd.com", "123", 123)
    Persistence::Repositories::RepositorioUsuarios.new.save(usuario)
  }
  let(:publicacion) {
    publicacion = Publicacion.new(100, usuario, auto, TipoP2P.new, 1)
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
      expect(oferta.monto).to eq 100
      expect(oferta.oferente.id_telegram).to eq usuario.id_telegram
      expect(oferta.publicacion.id).to eq publicacion.id
    end

    it 'consultar una oferta de un usuario con una oferta debería traer los datos correctos' do
      repositorio.save(oferta)
      ofertas = repositorio.buscar_por_oferente(usuario.id)
      expect(ofertas.length).to eq 1
      oferta = ofertas[0]
      expect(oferta.monto).to eq 100
      expect(oferta.oferente).to eq usuario
    end

    it 'consultar una oferta asociada a una publicación debería traer los datos correctos' do
      repositorio.save(oferta)
      ofertas = repositorio.buscar_por_publicacion(publicacion.id)
      expect(ofertas.length).to eq 1
      oferta = ofertas[0]
      expect(oferta.monto).to eq 100
      expect(oferta.publicacion.id).to eq publicacion.id
    end
  end
end

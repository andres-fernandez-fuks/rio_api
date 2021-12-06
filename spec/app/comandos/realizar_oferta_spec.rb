require 'spec_helper'
require_relative '../../../app/comandos/realizar_oferta'
require_relative '../../../app/models/errors/errores'

describe RealizarOferta do
  let(:precio) {300000}
  let(:auto) {Auto.new("AAA000", "FORD", "AMAROK", 2019, 1)}
  let(:vendedor) { Usuario.new('vendedor', 'vendedor@gmail.com', '001') }
  let(:oferente) { Usuario.new('nombre', 'mail', '100') }
  let(:publicacion) {PublicacionP2P.new(precio, vendedor, auto, 1)}
  let(:repo_ofertas) {Persistence::Repositories::RepositorioOfertas.new}

  before(:each) do
    publicacion.cotizada
    Persistence::Repositories::RepositorioAutos.new.save(auto)
    Persistence::Repositories::RepositorioUsuarios.new.save(oferente)
    Persistence::Repositories::RepositorioUsuarios.new.save(vendedor)
    Persistence::Repositories::RepositorioPublicaciones.new.save(publicacion)
  end

  context 'Realizar una oferta por una publicación p2p' do
    it 'agrega la oferta a la publicación' do
      realizar_oferta = described_class.new.ejecutar(publicacion, precio, oferente)
      ofertas_de_publicacion = repo_ofertas.buscar_por_publicacion(publicacion.id)
      expect(ofertas_de_publicacion.length).to eq 1
      expect(ofertas_de_publicacion[0].id).to eq realizar_oferta.id
      expect(ofertas_de_publicacion[0].oferente).to eq realizar_oferta.oferente
    end
  end
end

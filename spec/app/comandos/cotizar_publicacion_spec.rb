require 'spec_helper'
require_relative '../../../app/comandos/cotizar_publicacion'


describe CotizarPublicacion do
  let(:vendedor) { Usuario.new('vendedor', 'vendedor@gmail.com', '001') }

  before(:each) do
    Persistence::Repositories::RepositorioUsuarios.new.save(vendedor)
  end

  context 'Dado una publicacion de un auto de 1994 y un informe sin fallas' do
    before(:each) do
      @auto = Auto.new("AAA000", "Peugeot", "505", 1994, 1)
      @publicacion = PublicacionP2P.new(100_000, vendedor, @auto, 1)
      guardar_publicacion(@auto, @publicacion)
      @informe = InformeDeRevision.new
    end

    it 'Cuando ejecuto la cotizacion entonces la publicacion esta en estado Cotizado' do
      cotizar_publicacion = CotizarPublicacion.new(@publicacion.id, @informe)
      cotizar_publicacion.ejecutar()
      publicacion = obtener_publicacion(@publicacion.id)
      expect(publicacion.estado).to eq EstadoCotizado.new
    end
  end
end

def guardar_publicacion(auto, publicacion)
  Persistence::Repositories::RepositorioAutos.new.save(auto)
  Persistence::Repositories::RepositorioPublicaciones.new.save(publicacion)
end

def obtener_publicacion(id)
  Persistence::Repositories::RepositorioPublicaciones.new.find(id)
end
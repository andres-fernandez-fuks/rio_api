require 'spec_helper'
require_relative '../../../app/comandos/cotizar_publicacion'


describe CotizarPublicacion do
  let(:vendedor) { Usuario.new('vendedor', 'vendedor@gmail.com', '001') }

  before(:each) do
    Persistence::Repositories::RepositorioUsuarios.new.save(vendedor)
    Persistence::Repositories::RepositorioUsuarios.new.save(UsuarioFiubak.new)
  end

  context 'Dado una publicacion de un auto de 1994 y un informe sin fallas' do
    before(:each) do
      auto = Auto.new("AAA000", "Peugeot", "505", 1994, 1)
      @publicacion = PublicacionP2P.new(100_000, vendedor, auto, 1)
      guardar_publicacion(auto, @publicacion)
      @informe = InformeDeRevision.new
    end

    it 'Cuando ejecuto la cotizacion entonces la publicacion esta en estado Cotizado' do
      cotizar_publicacion = CotizarPublicacion.new(@publicacion.id, @informe)
      cotizar_publicacion.ejecutar()
      publicacion = obtener_publicacion(@publicacion.id)
      expect(publicacion.estado).to eq EstadoCotizado.new
    end

    it 'Cuando ejecuto la cotizacion se crea una oferta de fiubak por 800.000' do
      CotizarPublicacion.new(@publicacion.id, @informe).ejecutar()
      ofertas = obtener_ofertas(@publicacion.id)
      expect(ofertas.length).to eq 1
      expect(ofertas[0].monto).to eq 800_000
      expect(ofertas[0].es_fiubak?).to eq true
    end

    it 'Cuando ejecuto la cotizacion entonces el comando tiene cotizacion_exitosa true' do
      cotizar_publicacion = CotizarPublicacion.new(@publicacion.id, @informe)
      cotizar_publicacion.ejecutar()
      expect(cotizar_publicacion.cotizacion_exitosa).to eq true
    end
  end

  context 'Dada una publicacion con auto de 1994 y un informe con falla estética grave' do
    before(:each) do
      auto = Auto.new("AAA000", "Peugeot", "505", 1994, 1)
      @publicacion = PublicacionP2P.new(100_000, vendedor, auto, 1)
      guardar_publicacion(auto, @publicacion)
      @informe = InformeDeRevision.new.con_falla_estetica(InformeDeRevision::GRAVEDAD_GRAVE)
    end

    it 'Cuando ejecuto la cotizacion entonces la publicacion esta en estado cancelado' do
      cotizar_publicacion = CotizarPublicacion.new(@publicacion.id, @informe)
      cotizar_publicacion.ejecutar()
      publicacion = obtener_publicacion(@publicacion.id)

      expect(publicacion.estado).to eq EstadoCancelado.new
    end

    it 'Cuando ejecuto la cotizacion entonces el comando tiene cotizacion_exitosa en falso' do
      cotizar_publicacion = CotizarPublicacion.new(@publicacion.id, @informe)
      cotizar_publicacion.ejecutar()

      expect(cotizar_publicacion.cotizacion_exitosa).to eq false
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

def obtener_ofertas(id_publicacion)
  Persistence::Repositories::RepositorioOfertas.new.buscar_por_publicacion(id_publicacion)
end 

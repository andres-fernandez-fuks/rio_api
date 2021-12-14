require 'spec_helper'
require_relative '../../../app/comandos/cotizacion_exitosa'


describe CotizacionExitosa do
  let(:vendedor) { Usuario.new('vendedor', 'vendedor@gmail.com', '001') }
  
  let(:repo_ofertas) {Persistence::Repositories::RepositorioOfertas.new}
  let(:repo_publicaciones) {Persistence::Repositories::RepositorioPublicaciones.new}
  let(:repo_usuarios) {Persistence::Repositories::RepositorioUsuarios.new}
  before(:each) do
    Persistence::Repositories::RepositorioUsuarios.new.save(vendedor)
    Persistence::Repositories::RepositorioUsuarios.new.save(UsuarioFiubak.new)
  end

  context 'Dada una cotizacion exitosa con monto 800.000' do
    before(:each) do
      auto = Auto.new("AAA000", "Peugeot", "505", 1994, 1)
      @publicacion = PublicacionP2P.new(100_000, vendedor, auto, 1)
      guardar_publicacion(auto, @publicacion)
      @cotizacion_exitosa = CotizacionExitosa.new(@publicacion, 800_000, repo_ofertas, repo_publicaciones, repo_usuarios)
      @informe = InformeDeRevision.new
    end

    it 'Cuando ejecuto la cotizacion entonces la publicacion esta en estado Cotizado' do
      @cotizacion_exitosa.ejecutar()
      publicacion = obtener_publicacion(@publicacion.id)
      expect(publicacion.estado).to eq EstadoCotizado.new
    end

    it 'Cuando ejecuto la cotizacion se crea una oferta de fiubak por 800.000' do
      @cotizacion_exitosa.ejecutar()
      ofertas = obtener_ofertas(@publicacion.id)
      expect(ofertas.length).to eq 1
      expect(ofertas[0].monto).to eq 800_000
      expect(ofertas[0].es_fiubak?).to eq true
    end

    it 'Cuando ejecuto la cotizacion se envia un mail de notificacion por la oferta' do
      expect_any_instance_of(NotificadorDeOferta).to receive(:notificar)
      @cotizacion_exitosa.ejecutar()
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
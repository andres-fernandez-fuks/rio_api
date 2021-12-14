require 'spec_helper'
require_relative '../../../app/comandos/cotizacion_fallida'


describe CotizacionFallida do
  let(:vendedor) { Usuario.new('vendedor', 'vendedor@gmail.com', '001') }

  before(:each) do
    Persistence::Repositories::RepositorioUsuarios.new.save(vendedor)
    Persistence::Repositories::RepositorioUsuarios.new.save(UsuarioFiubak.new)
  end

  context 'Dada una cotizacion fallida para una publicacion' do
    before(:each) do
      auto = Auto.new("AAA000", "Peugeot", "505", 1994, 1)
      @publicacion = PublicacionP2P.new(100_000, vendedor, auto, 1)
      guardar_publicacion(auto, @publicacion)
      @cotizacion_fallida = CotizacionFallida.new(@publicacion, Persistence::Repositories::RepositorioPublicaciones.new)
    end

    it 'Cuando ejecuto la cotizacion entonces la publicacion esta en estado cancelado' do
      @cotizacion_fallida.ejecutar()
      expect(@publicacion.estado).to eq EstadoCancelado.new
    end

    it 'Cuando ejecuto la cotizacion entonces no se crea ninguna oferta' do
      @cotizacion_fallida.ejecutar()
      ofertas = obtener_ofertas(@publicacion.id)
      expect(ofertas.length).to eq 0
    end
  end
end

def guardar_publicacion(auto, publicacion)
  Persistence::Repositories::RepositorioAutos.new.save(auto)
  Persistence::Repositories::RepositorioPublicaciones.new.save(publicacion)
end

def obtener_ofertas(id_publicacion)
  Persistence::Repositories::RepositorioOfertas.new.buscar_por_publicacion(id_publicacion)
end 
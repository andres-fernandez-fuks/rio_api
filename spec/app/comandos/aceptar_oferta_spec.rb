require 'spec_helper'
require_relative '../../../app/comandos'
require_relative '../../../app/models/errors/errores'

describe AceptarOferta do
  let(:precio) {300000}
  let(:auto) {Auto.new("AAA000", "FORD", "AMAROK", 2019, 1)}
  let(:oferente) {Usuario.new('nombre', 'mail', '100')}
  let(:publicacion) {PublicacionP2P.new(precio, oferente, auto, 1)}
  let(:oferta) {Oferta.new(precio, oferente, publicacion)}

  before(:each) do
    Persistence::Repositories::RepositorioAutos.new.save(auto)
    Persistence::Repositories::RepositorioUsuarios.new.save(oferente)
    Persistence::Repositories::RepositorioPublicaciones.new.save(publicacion)
    Persistence::Repositories::RepositorioOfertas.new.save(oferta)
  end

  context 'Aceptar una oferta FIUBAK ' do
    it 'marca la publicación como vendida' do
      aceptar_oferta = described_class.new.ejecutar(oferta)
      expect(aceptar_oferta.publicacion.estado).to eq EstadoVendido.new
    end

    it 'guarda los cambios correctamente' do
      aceptar_oferta = described_class.new.ejecutar(oferta)
      oferta = Persistence::Repositories::RepositorioOfertas.new.find(aceptar_oferta.id)
      publicacion = oferta.publicacion
      expect(publicacion.estado).to eq EstadoVendido.new
    end

    it 'crea una publicacion nueva con incremento de precio' do

      described_class.new.ejecutar(oferta)
      publicaciones = Persistence::Repositories::RepositorioPublicaciones.new.all
      expect(publicaciones.length).to eq 2
      expect(publicaciones[0].precio > publicaciones[1].precio).to eq true
    end

    it 'crea una publicacion nueva de tipo fiubak' do
      described_class.new.ejecutar(oferta)
      publicaciones = Persistence::Repositories::RepositorioPublicaciones.new.all
      publicacion_creada_por_fiubak = publicaciones.find { |pub| pub.id != publicacion.id }
      expect(publicacion_creada_por_fiubak.tipo).to eq TipoFiubak.new
    end

    it 'la publicacion creada por fiubak se encuentra activa' do
      described_class.new.ejecutar(oferta)
      publicaciones = Persistence::Repositories::RepositorioPublicaciones.new.all
      publicacion_creada_por_fiubak = publicaciones.find { |pub| pub.id != publicacion.id }
      expect(publicacion_creada_por_fiubak.estado).to eq EstadoActivo.new
    end

    it 'marca la oferta como aceptada' do
      aceptar_oferta = described_class.new.ejecutar(oferta)
      oferta = Persistence::Repositories::RepositorioOfertas.new.find(aceptar_oferta.id)
      expect(oferta.estado).to eq EstadoAceptada.new
    end
  end
  
  context 'Dado que acepté la oferta por una publicacion' do
    before(:each) do
      described_class.new.ejecutar(oferta)
    end

    it 'Cuando intento aceptar otra oferta deberia lanzar un error' do
      otra_oferta = Oferta.new(100000, oferente, publicacion)
      expect{ described_class.new.ejecutar(otra_oferta) }.to raise_error PublicacionVendidaError
    end
  end
end

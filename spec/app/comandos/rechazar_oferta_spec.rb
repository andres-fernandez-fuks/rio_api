require 'spec_helper'
require_relative '../../../app/comandos/rechazar_oferta'

describe RechazarOferta do
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
    @oferta_rechazada = described_class.new.ejecutar(oferta)
    @oferta_persistida = Persistence::Repositories::RepositorioOfertas.new.find(@oferta_rechazada.id)
  end

  context 'Rechazar una oferta FIUBAK ' do
    it 'marca la publicacion como activa' do
      publicacion = @oferta_persistida.publicacion
      expect(publicacion.estado).to eq EstadoActivo.new
    end

    it 'guarda los cambios correctamente' do
      publicacion = @oferta_persistida.publicacion
      expect(publicacion.estado).to eq EstadoActivo.new
    end

    it 'mantiene el precio original de la publicacion' do
      publicacion_persistida = @oferta_persistida.publicacion
      expect(publicacion_persistida.precio).to eq publicacion.precio
    end

    it 'mantiene el precio original' do
      publicacion_persistida = @oferta_persistida.publicacion
      expect(publicacion_persistida.precio).to eq publicacion.precio
    end

    it 'marca la oferta como rechazada' do
      expect(@oferta_persistida.estado).to eq EstadoRechazada.new
    end
  end
end

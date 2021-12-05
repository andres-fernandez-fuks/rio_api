require 'spec_helper'
require_relative '../../../app/comandos/rechazar_oferta'

describe RechazarOferta do
  let(:precio) {300000}
  let(:auto) {Auto.new("AAA000", "FORD", "AMAROK", 2019, 1)}
  let(:oferente) {Usuario.new('nombre', 'mail', '100')}
  let(:publicacion) {Publicacion.new(precio, oferente, auto, TipoP2P.new, 1)}
  let(:oferta) {Oferta.new(precio, oferente, publicacion)}

  before(:each) do
    Persistence::Repositories::RepositorioAutos.new.delete_all
    Persistence::Repositories::RepositorioOfertas.new.delete_all
    Persistence::Repositories::RepositorioPublicaciones.new.delete_all
    Persistence::Repositories::RepositorioUsuarios.new.delete_all
    Persistence::Repositories::RepositorioAutos.new.save(auto)
    Persistence::Repositories::RepositorioUsuarios.new.save(oferente)
    Persistence::Repositories::RepositorioPublicaciones.new.save(publicacion)
    Persistence::Repositories::RepositorioOfertas.new.save(oferta)
    @oferta_rechazada = described_class.new.ejecutar(oferta)
  end

  context 'Rechazar una oferta FIUBAK ' do
    it 'marca la publicacion como activa' do
      oferta = Persistence::Repositories::RepositorioOfertas.new.find(@oferta_rechazada.id)
      publicacion = oferta.publicacion
      expect(publicacion.estado).to eq EstadoActivo.new
    end

    xit 'guarda los cambios correctamente' do
      oferta = Persistence::Repositories::RepositorioOfertas.new.find(@oferta_rechazada.id)
      publicacion = oferta.publicacion
      expect(publicacion.estado).to eq EstadoActivo.new
    end

    xit 'mantiene el precio original de la publicacion' do
      oferta_persistida = Persistence::Repositories::RepositorioOfertas.new.find(@oferta_rechazada.id)
      publicacion_persistida = oferta_persistida.publicacion
      expect(publicacion_persistida.precio).to eq publicacion.precio
    end

    xit 'mantiene el precio original' do
      oferta_persistida = Persistence::Repositories::RepositorioOfertas.new.find(@oferta_rechazada.id)
      publicacion_persistida = oferta_persistida.publicacion
      expect(publicacion_persistida.precio).to eq publicacion.precio
    end
  end
end

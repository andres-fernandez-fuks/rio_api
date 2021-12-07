require 'spec_helper'

describe Oferta do
  let(:precio) {300000}
  let(:oferente) {Usuario.new('nombre', 'mail', '100')}
  let(:usuario_fiubak) {UsuarioFiubak.new}
  let(:publicacion) {PublicacionP2P.new(precio, oferente, 1)}
  let(:oferta_fiubak) {described_class.new(precio, usuario_fiubak, publicacion)}
  let(:oferta) {described_class.new(precio, oferente, publicacion)}
  
  context 'Creación de una oferta' do
    it 'la oferta se crea correctamente' do
      oferta = described_class.new(precio, oferente, publicacion)
      expect(oferta.publicacion.id).to eq publicacion.id
      expect(oferta.oferente.nombre).to eq oferente.nombre
    end

    it 'la oferta es de fiubak si su oferente es el usuario fiubak' do
      oferta = described_class.new(precio, usuario_fiubak, publicacion)
      expect(oferta.es_fiubak?).to eq true
    end

    it 'la oferta es p2p si su oferente no es el usuario fiubak' do
      oferta = described_class.new(precio, oferente, publicacion)
      expect(oferta.es_p2p?).to eq true
    end

    it 'la oferta tiene estado pendiente' do
      expect(oferta.estado).to be_a(EstadoPendiente)
    end
  end

  describe 'Al aceptar la oferta' do
    it 'la oferta se pasa a estado aceptada' do
      oferta.aceptar
      expect(oferta.estado).to be_a(EstadoAceptada)
    end
  end

  describe 'Al rechazar la oferta' do
    it 'la oferta se pasa a estado rechazada' do
      oferta.rechazar
      expect(oferta.estado).to be_a(EstadoRechazada)
    end
  end
end

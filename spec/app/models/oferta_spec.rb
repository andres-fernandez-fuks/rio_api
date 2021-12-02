require 'spec_helper'

describe Oferta do
  let(:precio) {300000}
  let(:oferente) {Usuario.new('nombre', 'mail', '100')}
  let(:publicacion) {Publicacion.new(precio, oferente, 1)}
  let(:oferta) {described_class.new(precio, oferente, publicacion)}
  
  context 'Creación de una oferta' do
    it 'la oferta se crea correctamente' do
      oferta = described_class.new(precio, oferente, publicacion)
      expect(oferta.publicacion.id).to eq publicacion.id
      expect(oferta.oferente.nombre).to eq oferente.nombre
    end
  end

  describe 'Al aceptar la oferta' do
    it 'la oferta se acepta correctamente' do
      oferta.aceptar
      expect(oferta.publicacion.estado).to be_a(EstadoVendido)
    end
  end
end

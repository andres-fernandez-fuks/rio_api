require 'spec_helper'

describe Oferta do
  context 'Creación de una oferta' do
    let(:precio) {300000}
    let(:oferente) {Usuario.new('nombre', 'mail', '100')}
    let(:publicacion) {Publicacion.new(precio, oferente, 1)}

    it 'la oferta se crea correctamente' do
      oferta = described_class.new(precio, oferente, publicacion)
      expect(oferta.publicacion.id).to eq publicacion.id
      expect(oferta.oferente.nombre).to eq oferente.nombre
    end
  end
end

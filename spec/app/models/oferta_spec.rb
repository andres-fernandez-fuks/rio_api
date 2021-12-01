require 'spec_helper'

describe Oferta do
  context 'Creación de una oferta' do
    let(:precio) {300000}
    let(:id_publicacion) {100}
    let(:oferente) {Usuario.new('nombre', 'mail', '100')}

    it 'la oferta se crea correctamente' do
      oferta = described_class.new(precio, oferente, id_publicacion)
      expect(oferta.id_publicacion).to eq id_publicacion
      expect(oferta.oferente.nombre).to eq oferente.nombre
    end
  end
end

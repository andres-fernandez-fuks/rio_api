require 'spec_helper'

describe Publicacion do
  context 'Creación de una publicacion' do
    let(:precio) {300000}
    let(:usuario) {Usuario.new("Manuel", "asd@asd.com", "123")}
    it 'cuando se crea con todos sus campos validos' do
      publicacion = described_class.new(precio, usuario)
      expect(publicacion.precio).to eq precio
      expect(publicacion.usuario).to eq usuario
    end
  end
end

require 'spec_helper'

ESTADO_REVISION = 0
ESTADO_ACTIVO = 1
ESTADO_VENDIDO = 2

describe Publicacion do
  context 'Creación de una publicacion' do
    let(:precio) {300000}
    let(:usuario) {Usuario.new("Manuel", "asd@asd.com", "123")}

    it 'cuando se crea con todos sus campos validos' do
      publicacion = described_class.new(precio, usuario)
      expect(publicacion.precio).to eq precio
      expect(publicacion.usuario).to eq usuario
    end

    it 'el estado de una publicación recién creada es ESTADO_REVISION' do
      publicacion = described_class.new(precio, usuario)
      expect(publicacion.estado).to eq ESTADO_REVISION
    end

    it 'cuando se activa, su estado pasa a ser ESTADO_ACTIVO' do
      publicacion = described_class.new(precio, usuario)
      publicacion.activar
      expect(publicacion.estado).to eq ESTADO_ACTIVO
    end
  end
end

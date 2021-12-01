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

    it 'el estado de una publicación recién creada es ESTADO_REVISION' do
      publicacion = described_class.new(precio, usuario)
      expect(publicacion.estado).to eq EstadoRevision.new
    end

    it 'cuando se activa, su estado pasa a ser ESTADO_ACTIVO' do
      publicacion = described_class.new(precio, usuario)
      publicacion.activar
      expect(publicacion.estado).to eq EstadoActivo.new
    end

    it 'cuando se activa, el precio del auto pasa a ser el indicado' do
      publicacion = described_class.new(precio, usuario)
      publicacion.activar
      expect(publicacion.precio).to eq 70000
    end
  end
end

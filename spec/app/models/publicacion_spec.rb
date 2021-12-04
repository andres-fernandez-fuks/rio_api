require 'spec_helper'

describe Publicacion do
  context 'Creación de una publicacion' do
    let(:precio) {300000}
    let(:usuario) {Usuario.new("Manuel", "asd@asd.com", "123")}
    let(:publicacion) {described_class.new(precio, usuario)}

    it 'cuando se crea con todos sus campos validos' do
      expect(publicacion.precio).to eq precio
      expect(publicacion.usuario).to eq usuario
    end

    it 'el estado de una publicación recién creada es ESTADO_REVISION' do
      expect(publicacion.estado).to eq EstadoRevision.new
    end

    it 'cuando una publicación en revisión se cotiza, su estado pasa a ser ESTADO_COTIZADO' do
      publicacion = described_class.new(precio, usuario)
      publicacion.cotizada
      expect(publicacion.estado).to eq EstadoCotizado.new
    end

    it 'cuando una publicación que no está en revisión se cotiza, su estado no se modifica' do
      publicacion = described_class.new(precio, usuario)
      publicacion.vendida
      publicacion.cotizada
      expect(publicacion.estado).not_to eq EstadoCotizado.new
    end

    it 'cuando se activa, su estado pasa a ser ESTADO_ACTIVO' do
      publicacion.activar
      expect(publicacion.estado).to eq EstadoActivo.new
    end

    it 'cuando se activa, el precio del auto pasa a ser el indicado' do
      publicacion.activar
      expect(publicacion.precio).to eq publicacion.precio
    end

    it 'cuando se vende, cambia su estado a vendida' do
      publicacion.vendida
      expect(publicacion.estado).to be_a(EstadoVendido)
    end
  end
end

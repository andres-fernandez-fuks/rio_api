require 'spec_helper'

describe PublicacionP2P do
  context 'Creación de una publicación p2p' do
    let(:auto) {Auto.new("AAA000", "FORD", "AMAROK", 2019)}
    let(:precio) {300000}
    let(:usuario) {Usuario.new("Manuel", "asd@asd.com", "123")}
    let(:publicacion_p2p) {described_class.new(precio, usuario, auto)}

    it 'cuando se crea con todos sus campos validos' do
      expect(publicacion_p2p.precio).to eq precio
      expect(publicacion_p2p.usuario).to eq usuario
      expect(publicacion_p2p.tipo).to eq TipoP2P.new
    end

    it 'el estado de una publicación recién creada es ESTADO_REVISION' do
      expect(publicacion_p2p.estado).to eq EstadoRevision.new
    end

    it 'cuando una publicación en revisión se cotiza, su estado pasa a ser ESTADO_COTIZADO' do
      publicacion_p2p = described_class.new(precio, usuario, auto)
      publicacion_p2p.cotizada
      expect(publicacion_p2p.estado).to eq EstadoCotizado.new
    end

    it 'cuando una publicación que no está en revisión se cotiza, su estado no se modifica' do
      publicacion_p2p = described_class.new(precio, usuario, auto)
      publicacion_p2p.vendida
      publicacion_p2p.cotizada
      expect(publicacion_p2p.estado).not_to eq EstadoCotizado.new
    end

    it 'cuando se activa, su estado pasa a ser ESTADO_ACTIVO' do
      publicacion_p2p.activar
      expect(publicacion_p2p.estado).to eq EstadoActivo.new
    end

    it 'cuando se activa, el precio del auto pasa a ser el indicado' do
      publicacion_p2p.activar
      expect(publicacion_p2p.precio).to eq publicacion_p2p.precio
    end

    it 'cuando se vende, cambia su estado a vendida' do
      publicacion_p2p.vendida
      expect(publicacion_p2p.estado).to be_a(EstadoVendido)
    end
  end
end

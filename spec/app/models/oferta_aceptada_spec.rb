require 'spec_helper'

describe OfertaAceptada do
  let(:id_publicacion_fiubak) {1000}
  let(:oferente) {Usuario.new('nombre', 'mail', '100')}
  let(:auto) {Auto.new("AAA000", "FORD", "AMAROK", 2019)}
  let(:publicacion) {PublicacionP2P.new(10_000, oferente, 1)}
  let(:oferta) {Oferta.new(10_000, oferente, publicacion)}

  context 'Creación de una oferta' do
    it 'la oferta aceptada se crea correctamente' do
      oferta_aceptada = described_class.new(oferta, id_publicacion_fiubak)
      expect(oferta_aceptada.oferta.id).to eq oferta.id
      expect(oferta_aceptada.id_publicacion_fiubak).to eq id_publicacion_fiubak
    end
  end
end

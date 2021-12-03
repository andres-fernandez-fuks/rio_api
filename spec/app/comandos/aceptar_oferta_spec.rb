require 'spec_helper'
require_relative '../../../app/comandos/aceptar_oferta'
describe AceptarOferta do
  let(:precio) {300000}
  let(:oferente) {Usuario.new('nombre', 'mail', '100')}
  let(:publicacion) {Publicacion.new(precio, oferente, 1)}
  let(:oferta) {Oferta.new(precio, oferente, publicacion)}
  
  context 'Aceptar una oferta FIUBAK ' do
    it 'marca la publicación como vendida' do
      aceptar_oferta = described_class.ejecutar(oferta)
      expect(aceptar_oferta.publicacion.estado).to eq EstadoVendido.new
    end
  end
end

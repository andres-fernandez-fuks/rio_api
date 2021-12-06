require 'spec_helper'

describe PublicacionFiubak do
  let(:auto) {Auto.new("AAA000", "FORD", "AMAROK", 2019)}
  let(:precio) {300000}
  let(:fiubak) { Usuario.new('fiubak', 'fiubak@fiubak.com', '12345678')}
  let(:publicacion_fiubak) { described_class.new(precio, fiubak, auto) }

  it 'Al crear la publicacion debería estar activa' do
    expect(publicacion_fiubak.estado).to eq EstadoActivo.new
  end

  it 'El tipo debería ser TipoFiubak' do
    expect(publicacion_fiubak.tipo).to eq TipoFiubak.new
  end
end
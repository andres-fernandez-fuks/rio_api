require 'spec_helper'
require 'integration_helper'
describe Persistence::Repositories::RepositorioAutos do
  let(:repositorio) { described_class.new }
  let(:patente) {'ABC001'}
  let(:marca) {'FORD'}
  let(:modelo) {'AMAROK'}
  let(:anio) {2019}
  let(:auto) {Auto.new(patente, marca, modelo, anio)}

  before(:each) do
    repositorio.delete_all
  end

  context 'Guardado de auto' do
    it 'guardar un auto lo guarda correctamente' do
      id = repositorio.save(auto).id
      auto = repositorio.find(id)
      expect(auto.patente).to eq patente
      expect(auto.marca).to eq marca
      expect(auto.modelo).to eq modelo
      expect(auto.anio).to eq anio
    end
  end
end

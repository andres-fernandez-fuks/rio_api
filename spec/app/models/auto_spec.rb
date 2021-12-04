require 'spec_helper'

describe Auto do
  let(:patente) {'ABC001'}
  let(:marca) {'FORD'}
  let(:modelo) {'AMAROK'}
  let(:anio) {2019}

  context 'Creación de un auto' do
    it 'el auto se crea correctamente' do
      auto = described_class.new(patente, marca, modelo, anio)
      expect(auto.patente).to eq patente
      expect(auto.marca).to eq marca
      expect(auto.modelo).to eq modelo
      expect(auto.anio).to eq anio
    end
  end
end

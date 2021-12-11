require 'spec_helper'

describe InformeDeRevision do
  context 'Dada un informe creado con ninguna falla' do
    before(:each) do
      @informe = InformeDeRevision.new
    end

    it 'Cuando consulto por falla estetica entonces devuelve gravedad nula' do
      expect(@informe.falla_estetica).to eq InformeDeRevision::GRAVEDAD_NULA
    end

    it 'Cuando consulto por falla de neumaticos entonces devuelve gravedad nula' do
      expect(@informe.falla_de_neumaticos).to eq InformeDeRevision::GRAVEDAD_NULA
    end
  end
end

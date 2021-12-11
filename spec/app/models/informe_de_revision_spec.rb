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

    it 'Cuando consulto por falla de neumaticos entonces devuelve gravedad nula' do
      expect(@informe.falla_de_motor).to eq InformeDeRevision::GRAVEDAD_NULA
    end
  end

  context 'Dado un informe con falla estetica leve' do
    before(:each) do
      @informe = InformeDeRevision.new.con_falla_estetica(InformeDeRevision::GRAVEDAD_LEVE)
    end

    it 'Cuando consulto por falla estetica entonces devuelve gravedad leve' do
      expect(@informe.falla_estetica).to eq InformeDeRevision::GRAVEDAD_LEVE
    end
  end
end

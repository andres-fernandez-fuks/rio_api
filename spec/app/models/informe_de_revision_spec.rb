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

    it 'Cuando indico que tiene falla de motor leve y consulto por las fallas estetica y de motor, entonces devuelve gravedad leve para ambas' do
      informe_con_falla_de_motor = @informe.con_falla_de_motor(InformeDeRevision::GRAVEDAD_LEVE)
      expect(informe_con_falla_de_motor.falla_estetica).to eq InformeDeRevision::GRAVEDAD_LEVE
      expect(informe_con_falla_de_motor.falla_de_motor).to eq InformeDeRevision::GRAVEDAD_LEVE
    end

    it 'Cuando indico que tiene falla de neumaticos leve y consulto por falla de neumaticos, entonces devuelve gravedad leve' do
      expect(@informe.con_falla_de_neumaticos(InformeDeRevision::GRAVEDAD_LEVE).falla_de_neumaticos).to eq InformeDeRevision::GRAVEDAD_LEVE
    end
  end
end

require 'spec_helper'

describe Cotizador do
  let(:cotizador) { Cotizador.new }
  context 'Dado un auto de 1994' do
    before(:each) do
      @auto = Auto.new('AAA123', 'Peugeot', '505', '1994')
    end
    
    it 'Si lo cotizo con un informe sin fallas entonces la cotizacion es de 800.000' do
      informe = InformeDeRevision.new
      expect(cotizador.cotizar(@auto, informe)).to eq 800_000
    end
  end
end
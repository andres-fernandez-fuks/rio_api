require 'spec_helper'

describe Cotizador do
  let(:cotizador) { Cotizador.new }
  let(:vendedor) { Usuario.new('vendedor', 'vendedor@gmail.com', '001') }

  context 'Dado una publicacion con auto de 1994' do
    before(:each) do
      auto = Auto.new('AAA123', 'Peugeot', '505', 1994)
      @publicacion = PublicacionP2P.new(100_000, vendedor, auto, 1)
    end
    
    it 'Si la cotizo con un informe sin fallas entonces la cotizacion es de 800.000' do
      informe = InformeDeRevision.new
      expect(cotizador.cotizar(@publicacion, informe).monto).to eq 800_000
    end
  end

  context 'Dado una publicacion con auto de 1995' do
    before(:each) do
      auto = Auto.new('AAA123', 'Peugeot', '505', 1995)
      @publicacion = PublicacionP2P.new(100_000, vendedor, auto, 1)
    end

    it 'Si la cotizo con un informe sin fallas entonces la cotizacion es de 1.000.000' do
      informe = InformeDeRevision.new
      expect(cotizador.cotizar(@publicacion, informe).monto).to eq 1_000_000
    end
  end

  context 'Dada una publicacion con auto de 2010' do
    before(:each) do
      auto = Auto.new('AAA123', 'Ford', 'Fiesta', 2010)
      @publicacion = PublicacionP2P.new(100_000, vendedor, auto, 1)
    end

    it 'Si la cotizo con un informe sin fallas entonces la cotizacion es de 2.000.000' do
      informe = InformeDeRevision.new
      expect(cotizador.cotizar(@publicacion, informe).monto).to eq 2_000_000
    end    
  end
end
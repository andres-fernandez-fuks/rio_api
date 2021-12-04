class Auto
  attr_reader :patente, :marca, :modelo, :anio, :updated_on, :created_on
  attr_accessor :id

  def initialize(patente, marca, modelo, anio, id = nil)
    @id = id
    @patente = patente
    @marca = marca
    @modelo = modelo
    @anio = anio
  end
end

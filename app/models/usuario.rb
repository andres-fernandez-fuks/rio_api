class Usuario
  attr_reader :nombre, :mail, :id_telegram, :updated_on, :created_on

  def initialize(nombre, mail, id_telegram)
    @nombre = nombre
    @mail = mail
    @id_telegram = id_telegram
  end
end

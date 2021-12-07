class Usuario
  attr_reader :nombre, :mail, :id_telegram, :updated_on, :created_on
  attr_accessor :id

  def initialize(nombre, mail, id_telegram, id = nil)
    @nombre = nombre
    @mail = mail
    @id_telegram = id_telegram
    @id = id
  end

  def ==(other)
    @mail == other.mail
  end
end

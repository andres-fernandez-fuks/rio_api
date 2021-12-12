class Version
  MAYOR = 2 # Iteracion
  MINOR = 3 # Historia de usuario
  PATCH = 5

  def self.current
    "#{MAYOR}.#{MINOR}.#{PATCH}"
  end
end

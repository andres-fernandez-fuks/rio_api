class Version
  MAYOR = 1 # Iteracion
  MINOR = 5 # Historia de usuario
  PATCH = 4

  def self.current
    "#{MAYOR}.#{MINOR}.#{PATCH}"
  end
end

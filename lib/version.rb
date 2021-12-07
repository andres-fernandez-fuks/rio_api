class Version
  MAYOR = 1 # Iteracion
  MINOR = 4 # Historia de usuario
  PATCH = 1

  def self.current
    "#{MAYOR}.#{MINOR}.#{PATCH}"
  end
end

class Version
  MAYOR = 0 # Iteracion
  MINOR = 3 # Historia de usuario
  PATCH = 2

  def self.current
    "#{MAYOR}.#{MINOR}.#{PATCH}"
  end
end

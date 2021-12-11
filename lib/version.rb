class Version
  MAYOR = 2 # Iteracion
  MINOR = 0 # Historia de usuario
  PATCH = 0

  def self.current
    "#{MAYOR}.#{MINOR}.#{PATCH}"
  end
end

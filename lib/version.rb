class Version
  MAYOR = 2 # Iteracion
  MINOR = 1 # Historia de usuario
  PATCH = 1

  def self.current
    "#{MAYOR}.#{MINOR}.#{PATCH}"
  end
end

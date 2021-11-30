class Version
  MAYOR = 0 # Iteracion
  MINOR = 2 # Historia de usuario
  PATCH = 1

  def self.current
    "#{MAYOR}.#{MINOR}.#{PATCH}"
  end
end

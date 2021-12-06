require_relative 'comando'

class RegistrarUsuario < Comando
  def ejecutar(usuario)
    guardar_usuario(usuario)
  end
end

require_relative 'comando'

class RegistrarUsuario < Comando
  def ejecutar(usuario)
    raise MailDeUsuarioEnUsoError if Persistence::Repositories::RepositorioUsuarios.new.buscar_por_mail(usuario.mail)

    guardar_usuario(usuario)
  end
end

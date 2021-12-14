class RegistrarUsuario
  def initialize(repo_usuarios)
    @repo_usuarios = repo_usuarios
  end

  def ejecutar(usuario)
    raise MailDeUsuarioEnUsoError if @repo_usuarios.buscar_por_mail(usuario.mail)

    @repo_usuarios.save(usuario)
  end
end

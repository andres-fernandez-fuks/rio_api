# write seeds here
require_relative '../app/models/usuario'

repo_usuarios = Persistence::Repositories::RepositorioUsuarios.new
return if repo_usuarios.buscar_usuario_fiubak

usuario_fiubak = UsuarioFiubak.new
repo_usuarios.save usuario_fiubak

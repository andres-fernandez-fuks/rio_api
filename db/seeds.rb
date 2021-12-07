# write seeds here
require_relative '../app/models/usuario'

repo_usuarios = Persistence::Repositories::RepositorioUsuarios.new
return if repo_usuarios.all.count.positive?

usuario_fiubak = UsuarioFiubak.new
repo_usuarios.save usuario_fiubak

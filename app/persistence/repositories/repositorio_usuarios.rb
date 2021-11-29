module Persistence
  module Repositories
    class RepositorioUsuario < AbstractRepository
      self.table_name = :usuarios
      self.model_class = 'Usuario'

      protected

      def changeset(usuario)
        {
          nombre: usuario.nombre,
          mail: usuario.mail,
          id_telegram: usuario.id_telegram
        }
      end
    end
  end
end

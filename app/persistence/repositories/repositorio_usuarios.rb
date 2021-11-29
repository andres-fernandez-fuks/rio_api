module Persistence
  module Repositories
    class RepositorioUsuarios < AbstractRepository
      self.table_name = :usuarios
      self.model_class = 'Usuario'

      def buscar_por_id_telegram(id_telegram)
        row = dataset.first(id_telegram: id_telegram)
        load_object(row) unless row.nil?
      end

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

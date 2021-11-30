module Persistence
  module Repositories
    class RepositorioPublicaciones < AbstractRepository
      self.table_name = :publicaciones
      self.model_class = 'Publicacion'

      protected

      def load_object(a_record)
        Object.const_get(self.class.model_class).new(a_record[:precio],
                                                     RepositorioUsuarios.new.find(a_record[:usuario]))
      end

      def changeset(publicacion)
        {
          precio: publicacion.precio,
          usuario: publicacion.usuario.id
        }
      end
    end
  end
end

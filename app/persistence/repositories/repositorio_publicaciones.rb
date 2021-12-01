module Persistence
  module Repositories
    class RepositorioPublicaciones < AbstractRepository
      self.table_name = :publicaciones
      self.model_class = 'Publicacion'

      def buscar_por_usuario(id_usuario)
        load_collection dataset.where(usuario: id_usuario)
      end

      protected

      def load_object(a_record)
        Object.const_get(self.class.model_class).new(a_record[:precio],
                                                     RepositorioUsuarios.new.find(a_record[:usuario]),
                                                     a_record[:id])
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

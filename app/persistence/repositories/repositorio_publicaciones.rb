module Persistence
  module Repositories
    class RepositorioPublicaciones < AbstractRepository
      self.table_name = :publicaciones
      self.model_class = 'Publicacion'

      def buscar_activas
        load_collection dataset.where(Sequel.ilike(:estado, 'activo'))
      end

      protected

      def load_object(a_record)
        publicacion = Object.const_get(self.class.model_class).new(a_record[:precio],
                                                                   RepositorioUsuarios.new.find(a_record[:usuario]))
        configurar_estado(publicacion, a_record[:estado])
        publicacion
      end

      def changeset(publicacion)
        {
          precio: publicacion.precio,
          usuario: publicacion.usuario.id,
          estado: estado_a_string(publicacion.estado)
        }
      end

      def configurar_estado(publicacion, estado)
        publicacion.activar if estado == 'Activo'
      end

      def estado_a_string(estado)
        if estado.zero?
          'Revision'
        elsif estado == 1
          'Activo'
        else
          'Vendido'
        end
      end
    end
  end
end

module Persistence
  module Repositories
    class RepositorioPublicaciones < AbstractRepository
      self.table_name = :publicaciones
      self.model_class = 'Publicacion'

      def buscar_activas
        load_collection dataset.where(estado: EstadoActivo.new.id)
      end

      def buscar_por_usuario(id_usuario)
        load_collection dataset.where(usuario: id_usuario)
      end

      protected

      def load_object(a_record)
        publicacion = Object.const_get(self.class.model_class).new(a_record[:precio],
                                                                   RepositorioUsuarios.new.find(a_record[:usuario]),
                                                                   RepositorioAutos.new.find(a_record[:auto]),
                                                                   TipoP2P.new,
                                                                   a_record[:id])
        configurar_estado(publicacion, a_record[:estado])
        publicacion
      end

      def changeset(publicacion)
        {
          precio: publicacion.precio,
          usuario: publicacion.usuario.id,
          estado: publicacion.estado.id,
          auto: publicacion.auto.id
        }
      end

      def configurar_estado(publicacion, estado)
        publicacion.activar if estado == EstadoActivo.new.id
        publicacion.vendida if estado == EstadoVendido.new.id
      end
    end
  end
end

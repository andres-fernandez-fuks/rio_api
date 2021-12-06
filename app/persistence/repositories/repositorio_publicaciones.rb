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
        tipo = parsear_tipo(a_record[:tipo])
        subclase = tipo == TipoP2P.new ? PublicacionP2P : PublicacionFiubak
        publicacion = subclase.new(a_record[:precio],
                                   RepositorioUsuarios.new.find(a_record[:usuario]),
                                   RepositorioAutos.new.find(a_record[:auto]),
                                   a_record[:id])
        configurar_estado(publicacion, a_record[:estado])
        publicacion
      end

      def changeset(publicacion)
        {
          precio: publicacion.precio,
          usuario: publicacion.usuario.id,
          estado: publicacion.estado.id,
          tipo: serializar_tipo(publicacion.tipo),
          auto: publicacion.auto.id
        }
      end

      def configurar_estado(publicacion, estado)
        publicacion.activar if estado == EstadoActivo.new.id
        publicacion.vendida if estado == EstadoVendido.new.id
        publicacion.cotizada if estado == EstadoCotizado.new.id
      end

      def serializar_tipo(tipo)
        return 'p2p' if tipo == TipoP2P.new

        'fiubak'
      end

      def parsear_tipo(valor)
        return TipoP2P.new if valor == 'p2p'

        TipoFiubak.new
      end
    end
  end
end

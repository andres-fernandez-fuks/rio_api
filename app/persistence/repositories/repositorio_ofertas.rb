module Persistence
  module Repositories
    class RepositorioOfertas < AbstractRepository
      self.table_name = :ofertas
      self.model_class = 'Oferta'

      def buscar_por_oferente(id_usuario)
        load_collection dataset.where(oferente: id_usuario)
      end

      def buscar_por_publicacion(id_publicacion)
        load_collection dataset.where(publicacion: id_publicacion)
      end

      protected

      def load_object(a_record)
        oferta = Object.const_get(self.class.model_class).new(a_record[:precio],
                                                              RepositorioUsuarios.new.find(a_record[:oferente]),
                                                              RepositorioPublicaciones.new.find(a_record[:publicacion]),
                                                              a_record[:id])
        configurar_estado(oferta, a_record[:estado])
        oferta
      end

      def changeset(oferta)
        {
          precio: oferta.precio,
          oferente: oferta.oferente.id,
          publicacion: oferta.publicacion.id,
          estado: oferta.estado.id
        }
      end

      def configurar_estado(oferta, estado)
        oferta.establecer_estado(EstadoAceptada.new) if estado == EstadoAceptada.new.id
        oferta.establecer_estado(EstadoRechazada.new) if estado == EstadoRechazada.new.id
        oferta.establecer_estado(EstadoPendiente.new) if estado == EstadoPendiente.new.id
      end
    end
  end
end

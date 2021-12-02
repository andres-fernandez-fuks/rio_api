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
        Object.const_get(self.class.model_class).new(a_record[:precio],
                                                     RepositorioUsuarios.new.find(a_record[:oferente]),
                                                     RepositorioPublicaciones.new.find(a_record[:publicacion]),
                                                     a_record[:id])
      end

      def changeset(oferta)
        {
          precio: oferta.precio,
          oferente: oferta.oferente.id,
          publicacion: oferta.publicacion.id
        }
      end
    end
  end
end

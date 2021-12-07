module Persistence
  module Repositories
    class RepositorioUsuarios < AbstractRepository
      self.table_name = :usuarios
      self.model_class = 'Usuario'

      def buscar_por_id_telegram(id_telegram)
        row = dataset.first(id_telegram: id_telegram)
        load_object(row) unless row.nil?
      end

      def buscar_por_mail(mail)
        row = dataset.first(mail: mail)
        load_object(row) unless row.nil?
      end

      def buscar_usuario_fiubak
        row = dataset.first(mail: UsuarioFiubak.new.mail)
        load_object(row) unless row.nil?
      end

      protected

      def load_object(a_record)
        Object.const_get(self.class.model_class).new(a_record[:nombre], a_record[:mail], a_record[:id_telegram], a_record[:id])
      end

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

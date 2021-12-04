module Persistence
  module Repositories
    class RepositorioAutos < AbstractRepository
      self.table_name = :autos
      self.model_class = 'Auto'

      protected

      def load_object(a_record)
        Object.const_get(self.class.model_class).new(a_record[:patente], a_record[:marca], a_record[:modelo],
                                                     a_record[:anio], a_record[:id])
      end

      def changeset(auto)
        {
          patente: auto.patente,
          marca: auto.marca,
          modelo: auto.modelo,
          anio: auto.anio
        }
      end
    end
  end
end

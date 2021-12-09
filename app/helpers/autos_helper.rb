# Helper methods defined here can be accessed in any controller or view in the application

module WebTemplate
  class App
    module AutosHelper
      def repo_autos
        Persistence::Repositories::RepositorioAutos.new
      end

      def guardar_auto(parametros)
        auto = Auto.new(parametros[:patente], parametros[:marca], parametros[:modelo], parametros[:anio])
        repo_autos.save(auto)
      end

      def auto_a_json(auto)
        serializar_auto(auto).to_json
      end

      private

      def serializar_auto(auto)
        {
          patente: auto.patente,
          marca: auto.marca,
          modelo: auto.modelo,
          anio: auto.anio
        }
      end
    end
    helpers AutosHelper
  end
end

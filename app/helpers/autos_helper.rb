# Helper methods defined here can be accessed in any controller or view in the application

module WebTemplate
  class App
    module AutosHelper
      def repo_autos
        Persistence::Repositories::RepositorioAutos.new
      end

      def parsear_auto(parametros)
        Auto.new(parametros[:patente], parametros[:marca], parametros[:modelo], parametros[:anio])
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

# Helper methods defined here can be accessed in any controller or view in the application

module WebTemplate
  class App
    module AutosHelper
      def repo_autos
        Persistence::Repositories::RepositorioAutos.new
      end
    end
  end
end

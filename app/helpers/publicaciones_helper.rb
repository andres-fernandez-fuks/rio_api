# Helper methods defined here can be accessed in any controller or view in the application

module WebTemplate
  class App
    module PublicacionHelper
      def repo_publicaciones
        Persistence::Repositories::RepositorioPublicaciones.new
      end

      def params_publicacion
        @body ||= request.body.read
        JSON.parse(@body).symbolize_keys
      end

      def publicacion_a_json(publicacion)
        atributos_publicacion(publicacion).to_json
      end

      def publicacion_activada(publicacion)
        {
          id: publicacion.id,
          precio: publicacion.precio,
          estado: publicacion.estado
        }
      end

      def error_publicacion_no_encontrado
        {
          "error": 'publicacion no encontrada'
        }.to_json
      end

      private

      def atributos_publicacion(publicacion)
        {
          id: publicacion.id,
          precio: publicacion.precio,
          id_telegram: publicacion.usuario.id_telegram
        }
      end

      def publicacion_mapper
        Persistence::Mappers::PublicacionMapper.new
      end
    end

    helpers PublicacionHelper
  end
end

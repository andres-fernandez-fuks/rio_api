# Helper methods defined here can be accessed in any controller or view in the application

module WebTemplate
  class App
    module UsuarioHelper
      def repo_usuario
        Persistence::Repositories::RepositorioUsuario.new
      end

      def params_ususario
        @body ||= request.body.read
        JSON.parse(@body).symbolize_keys
      end

      def usuario_a_json(usuario)
        atributos_usuario(usuario).to_json
      end

      private

      def atributos_usuario(usuario)
        {
          id: usuario.id,
          nombre: usuario.nombre,
          mail: usuario.mail,
          id_telegram: usuario.id_telegram
        }
      end

      def usuario_mapper
        Persistence::Mappers::UsuarioMapper.new
      end
    end

    helpers UsuarioHelper
  end
end

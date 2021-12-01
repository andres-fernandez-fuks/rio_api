module WebTemplate
  class App
    module PublicacionHelper
      def repo_publicacion
        Persistence::Repositories::RepositorioPublicaciones.new
      end

      def params_usuario
        @body ||= request.body.read
        JSON.parse(@body).symbolize_keys
      end

      def usuario_a_json(usuario)
        atributos_usuario(usuario).to_json
      end

      def error_usuario_no_encontrado
        {
          "error": 'Usuario no registrado'
        }.to_json
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

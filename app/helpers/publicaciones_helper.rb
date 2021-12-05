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

      def cotizar_publicacion(publicacion)
        publicacion.cotizada
        repo_publicaciones.save(publicacion)
      end

      def crear_usuario_fiubak
        usuario = Usuario.new('fiubak', 'fiubak', 'fiubak')
        repo_usuario.save(usuario)
      end

      def publicacion_activada(publicacion)
        {
          id: publicacion.id,
          precio: publicacion.precio,
          estado: publicacion.estado,
          auto: publicacion.auto
        }.to_json
      end

      def listar_publicaciones(publicaciones)
        body = []
        publicaciones.each do |publicacion|
          info_publicacion = publicacion_activada(publicacion)
          body.append(info_publicacion)
        end
        body.to_json
      end

      def listar_mis_publicaciones(publicaciones)
        body = []
        publicaciones.each do |publicacion|
          info_publicacion =
            {
              id: publicacion.id,
              precio: publicacion.precio,
              estado: estado_a_string(publicacion.estado),
              auto: serializar_auto(publicacion.auto)
            }
          body.append(info_publicacion)
        end
        body.to_json
      end

      def error_publicacion_no_encontrado
        {
          "error": 'publicacion no encontrada'
        }.to_json
      end

      def estado_a_string(estado)
        return 'En revisión' if estado == EstadoRevision.new
        return 'Cotizado' if estado == EstadoCotizado.new
        return 'Activo' if estado == EstadoActivo.new
        return 'Vendido' if estado == EstadoVendido.new

        'Desconocido'
      end

      def guardar_publicacion(precio, usuario, auto)
        publicacion = Publicacion.new(precio, usuario, auto)
        repo_publicaciones.save(publicacion)
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

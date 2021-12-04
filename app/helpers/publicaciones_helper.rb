# Helper methods defined here can be accessed in any controller or view in the application

module WebTemplate
  class App
    module PublicacionHelper
      def repo_publicaciones
        Persistence::Repositories::RepositorioPublicaciones.new
      end

      def repo_autos
        Persistence::Repositories::RepositorioAutos.new
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
        }.to_json
      end

      def listar_publicaciones(publicaciones)
        body = []
        publicaciones.each do |publicacion|
          info_publicacion =
            {
              id: publicacion.id,
              precio: publicacion.precio
            }
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
              estado: estado_a_string(publicacion.estado)
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

      def guardar_auto(parametros)
        auto = Auto.new(parametros[:patente], parametros[:marca], parametros[:modelo], parametros[:anio])
        repo_autos.save(auto)
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

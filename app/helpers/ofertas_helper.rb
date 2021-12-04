# Helper methods defined here can be accessed in any controller or view in the application
require_relative '../comandos/aceptar_oferta'
module WebTemplate
  class App
    module OfertasHelper
      def repo_ofertas
        Persistence::Repositories::RepositorioOfertas.new
      end

      def params_oferta
        @body ||= request.body.read
        JSON.parse(@body).symbolize_keys
      end

      def oferta_a_json(oferta)
        {
          id: oferta.id,
          precio: oferta.precio,
          id_publicacion: oferta.publicacion.id,
          estado: oferta.estado,
          oferente: oferta.oferente.nombre
        }.to_json
      end

      def error_oferta_no_encontrada
        {
          "error": 'Oferta no encontrada'
        }.to_json
      end

      def listar_ofertas(ofertas)
        body = []
        ofertas.each do |oferta|
          info_oferta = oferta_a_json(oferta)
          body.append(info_oferta)
        end
        body.to_json
      end

      def aceptar_oferta(oferta)
        AceptarOferta.new.ejecutar(oferta)
      end

      private

      def oferta_mapper
        Persistence::Mappers::OfertaMapper.new
      end
    end

    helpers OfertasHelper
  end
end

# Helper methods defined here can be accessed in any controller or view in the application
require_relative '../comandos/aceptar_oferta'
require_relative '../comandos/rechazar_oferta'
require_relative '../comandos/realizar_oferta'
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

      def oferta_a_json(oferta, incluir_contacto: false)
        serializar_oferta(oferta, incluir_contacto).to_json
      end

      def serializar_oferta(oferta, incluir_contacto)
        {
          id: oferta.id,
          monto: oferta.monto,
          id_publicacion: oferta.publicacion.id,
          estado: estado_oferta_a_string(oferta.estado),
          mail: incluir_contacto ? oferta.oferente.mail : nil,
          oferente: oferta.oferente.nombre
        }
      end

      def estado_oferta_a_string(estado)
        return 'Aceptada' if estado == EstadoAceptada.new
        return 'Rechazada' if estado == EstadoRechazada.new
        return 'Pendiente' if estado == EstadoPendiente.new

        'Desconocido'
      end

      def error_oferta_no_encontrada
        {
          "error": 'Oferta no encontrada'
        }.to_json
      end

      def listar_ofertas(ofertas)
        body = []
        ofertas.each do |oferta|
          info_oferta = serializar_oferta(oferta, false)
          body.append(info_oferta)
        end
        body.to_json
      end

      def realizar_oferta(monto, oferente, publicacion)
        RealizarOferta.new.ejecutar(monto, oferente, publicacion)
      end

      def aceptar_oferta(oferta)
        AceptarOferta.new.ejecutar(oferta)
      end

      def rechazar_oferta(oferta)
        RechazarOferta.new.ejecutar(oferta)
      end

      private

      def oferta_mapper
        Persistence::Mappers::OfertaMapper.new
      end
    end

    helpers OfertasHelper
  end
end

# Helper methods defined here can be accessed in any controller or view in the application

module WebTemplate
  class App
    module InformeHelper
      def parsear_informe(request_body)
        informe = InformeDeRevision.new
        informe.con_falla_estetica(request_body[:estetica]) unless request_body[:estetica].nil?
        informe.con_falla_de_neumaticos(request_body[:neumaticos]) unless request_body[:neumaticos].nil?
        informe.con_falla_de_motor(request_body[:motor]) unless request_body[:motor].nil?
        informe
      end

      def formatear_para_mail(informe)
        "Su auto cuenta con las siguientes condiciones:
        Fallas esteticas: #{informe.falla_estetica}
        Fallas de motor: #{informe.falla_de_motor}
        Fallas de neumaticos: #{informe.falla_de_neumaticos}
        Nos estaremos contactando con usted a la brevedad.
        Saludos,
        Fiubak
        "
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
    helpers InformeHelper
  end
end

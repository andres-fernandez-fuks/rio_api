# Helper methods defined here can be accessed in any controller or view in the application
Dir['../models/estados_publicacion'].sort.each { |file| require file }

ID_ESTADO_EN_REVISION = 1
ID_ESTADO_ACTIVO = 2
ID_ESTADO_VENDIDO = 3

module WebTemplate
  class App
    module EstadosHelper
      def estado_a_string(estado)
        case estado.id
        when ID_ESTADO_EN_REVISION
          'En revisión'
        when ID_ESTADO_ACTIVO
          'Activo'
        when ID_ESTADO_VENDIDO
          'Vendido'
        else
          'Desconocido'
        end
      end
    end
  end
end

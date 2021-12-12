class NotificadorDeOferta
  def initialize(oferta)
    @oferta = oferta
  end

  def notificar
    EnviadorDeMails.enviar_mail_a(@oferta.publicacion.mail_usuario, 'foo', 'bar')
  end
end

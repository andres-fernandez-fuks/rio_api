class NotificadorDeOferta
  def initialize(oferta)
    @oferta = oferta
  end

  def notificar
    EnviadorDeMails.enviar_mail_a(@oferta.publicacion.mail_usuario, asunto_de_mail, 'bar')
  end

  private

  def asunto_de_mail
    'Has recibido una oferta por tu publicación'
  end
end

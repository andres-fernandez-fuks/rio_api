class NotificadorDeOferta
  def initialize(oferta)
    @oferta = oferta
  end

  def notificar
    EnviadorDeMails.enviar_mail_a(@oferta.publicacion.mail_usuario, asunto_de_mail, cuerpo_de_mail)
  end

  private

  def asunto_de_mail
    'Has recibido una oferta por tu publicación'
  end

  def cuerpo_de_mail
    "Has recibido una oferta por tu publicación con id #{@oferta.publicacion.id}

    Datos de la oferta:
      id: #{@oferta.id}
      usuario: #{@oferta.oferente.nombre}
      monto: #{@oferta.monto}

    Recuerde que puede ver las ofertas recibidas para su publicación en el bot enviando '/ofertas #{@oferta.publicacion.id}'
    "
  end
end

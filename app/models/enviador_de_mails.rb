class EnviadorDeMails
  @mail_desde = 'rio.job.vacancy@gmail.com'.freeze
  def self.enviar_mail_a(destinatario, asunto, mensaje)
    enviar(destinatario, asunto, mensaje)
  end

  def self.enviar_informe_a(destinatario, mensaje)
    asunto = 'Fiubak - El informe de tu auto ya está listo'
    enviar(destinatario, asunto, mensaje)
  end

  def self.enviar(destinatario, asunto, mensaje)
    WebTemplate::App.email(
      :from => @mail_desde,
      :to => destinatario,
      :subject => asunto,
      :body => mensaje
    )
  end
end

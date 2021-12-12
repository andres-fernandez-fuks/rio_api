require 'spec_helper'

describe NotificadorDeOferta do

  let(:precio) {300000}
  let(:usuario_publicacion) { Usuario.new('publicante', 'publicador@gmail.com', '200')}
  let(:oferente) {Usuario.new('nombre', 'mail', '100')}
  let(:publicacion) {PublicacionP2P.new(precio, usuario_publicacion, 1)}

  context 'Dada una oferta de 100.000 para una publicacion del usuario con email publicador@gmail.com' do
    before(:each) do
      @oferta = Oferta.new(100_000, oferente, publicacion, 1)
    end

    it 'Cuando envio la notificacion, se envia un mail al usuario que creó la publicación' do
      expect(EnviadorDeMails).to receive(:enviar_mail_a).with(usuario_publicacion.mail, anything, anything)
      NotificadorDeOferta.new(@oferta).notificar
    end

    it 'Cuando envio la notificaion, se envia un mail con asunto "Has recibido una oferta por tu publicación"' do
      expect(EnviadorDeMails).to receive(:enviar_mail_a).with(usuario_publicacion.mail, 'Has recibido una oferta por tu publicación', anything)
      NotificadorDeOferta.new(@oferta).notificar
    end

    it 'Cuando envio la notificacion, el cuerpo del mail contiene los datos de la oferta' do
      body_matcher = include("usuario: #{oferente.nombre}").and include("monto: #{@oferta.monto}").and include("id: #{@oferta.id}")
      expect(EnviadorDeMails).to receive(:enviar_mail_a).with(usuario_publicacion.mail, 'Has recibido una oferta por tu publicación', body_matcher)
      NotificadorDeOferta.new(@oferta).notificar
    end
  end
end
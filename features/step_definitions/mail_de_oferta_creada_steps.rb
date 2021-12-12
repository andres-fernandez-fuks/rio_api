Dado('tengo una publicación creada') do
  body = {patente: '100', marca: 'FORD', modelo: 'A', anio: 2000, precio: 50_000, id_telegram: @id_telegram}.to_json
  response = Faraday.post(crear_publicacion_url, body)
  @id_publicacion = JSON(response.body)['id']

  body = {}.to_json
  response = Faraday.post(informe_de_cotizacion_url(@id_publicacion), body)
  id_oferta = JSON(response.body)['id']
  body = {estado: 'rechazada'}.to_json
  Faraday.post(rechazar_oferta_url(id_oferta), body)
end

Cuando('se crea una oferta para la publicación') do
  @ofertante = {nombre: 'ofertante', mail: 'ofertante@gmail.com', id_telegram: '45678'}
  Faraday.post(crear_usuario_url, @ofertante.to_json, header)
  header_oferta = { 'ID_TELEGRAM' => '45678' }
  @oferta = { precio: 100_000 }
  respuesta = Faraday.post(realizar_oferta_url(@id_publicacion), @oferta.to_json, header_oferta)
  @id_oferta = JSON(respuesta.body)['id']
end

Entonces('recibo un correo electrónico con los datos de la oferta a la dirección {string}') do |mail|
  mail_store = "#{Padrino.root}/tmp/emails"
  file = File.open("#{mail_store}/#{mail}", 'r')
  @content = file.read
end

Entonces('se puede ver el id de la publicación') do
  @content.include?(@id_publicacion.to_s).should be true
end

Entonces('se puede ver el id de la oferta') do
  @content.include?("id: #{@id_oferta}").should be true
end

Entonces('se puede ver el nombre del usuario ofertante') do
  @content.include?("usuario: #{@ofertante['nombre']}").should be true
end

Entonces('se puede ver el monto de la oferta') do
  @content.include?("monto: #{@oferta['precio']}").should be true
end

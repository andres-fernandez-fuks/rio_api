Dado('que estoy registrado con el email {string}') do |mail|
  FileUtils.rm_f Dir.glob("#{Padrino.root}/tmp/emails/*")
  nombre = 'Cualquiera'
  @id_telegram = '123'
  body = {nombre: nombre, mail: mail, id_telegram: @id_telegram}.to_json
  Faraday.post(crear_usuario_url, body, header)
end

Dado('tengo una publicación en revisión') do
  body = {patente: 'patente', marca: 'marca', modelo: 'modelo', anio: 2014, precio: 10_000, id_telegram: @id_telegram}.to_json
  respuesta = Faraday.post(crear_publicacion_url, body, header)
  @id_publicacion = JSON(respuesta.body)['id']
end

Cuando('se realiza la cotización') do
  body = {}.to_json
  Faraday.post(informe_de_cotizacion_url(@id_publicacion), body)
end

Entonces('recibo un correo electrónico con el informe de la cotización a la dirección {string}') do |mail|
  mail_store = "#{Padrino.root}/tmp/emails"
  file = File.open("#{mail_store}/#{mail}", 'r')
  @content = file.read
end

Entonces('se puede ver la gravedad de las fallas estéticas') do
  @content.include?('Fallas esteticas: Ninguna').should be true
end

Entonces('se puede ver la gravedad de las fallas de motor') do
  @content.include?('Fallas de motor: Ninguna').should be true
end

Entonces('se puede ver la gravedad de las fallas de neumáticos') do
  @content.include?('Fallas de neumaticos: Ninguna').should be true
end

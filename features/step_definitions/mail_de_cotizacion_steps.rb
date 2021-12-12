Dado('que estoy registrado con el email {string}') do |mail|
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

Cuando('se realiza la cotización con fallas esteticas {string}, con fallas de motor {string} y con fallas de neumaticos {string}') do |fallas_esteticas, fallas_de_motor, fallas_de_neumaticos|
  body = {
    estetica: fallas_esteticas,
    motor: fallas_de_motor,
    neumaticos: fallas_de_neumaticos
  }.to_json
  Faraday.post(informe_de_cotizacion_url(@id_publicacion), body)
end

Entonces('recibo un correo electrónico con el informe de la cotización a la dirección {string}') do |mail|
  mail_store = "#{Padrino.root}/tmp/emails"
  file = File.open("#{mail_store}/#{mail}", 'r')
  @content = file.read
end

Entonces('se puede ver la gravedad {string} de las fallas {string}') do |gravedad, falla|
  @content.include?("Fallas #{falla}: #{gravedad}").should be true
end

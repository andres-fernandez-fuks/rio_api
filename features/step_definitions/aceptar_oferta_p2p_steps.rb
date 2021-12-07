Dado('que tengo una publicación p2p por un auto patente {string}, marca {string}, modelo {string}, año {int} y precio {float}') do |patente, marca, modelo, anio, precio|
  body_registro = {patente: patente, marca: marca, modelo: modelo, anio: anio, precio: precio, id_telegram: @id_telegram}.to_json
  response = Faraday.post(crear_publicacion_url, body_registro, header)
  @id_publicacion = JSON(response.body)['id']
  response = Faraday.post(informe_de_cotizacion_url(@id_publicacion), {precio: 70_000}.to_json)
  id_oferta = JSON(response.body)['id']
  Faraday.patch(rechazar_oferta_url(id_oferta), {estado: 'rechazada'}.to_json)
end

Dado('hay una oferta p2p por 2000000 para la publicación del usuario con email {string}') do |email|
  @email = email
  @id_oferta = crear_oferta_p2p(email)
end

Dado('que hay otra oferta p2p') do
  @id_otra_oferta = crear_oferta_p2p('otro_oferente@test.com')
end

Dado('que acepto la primer oferta p2p') do
  @response = aceptar_oferta(@id_oferta)
end

Dado('Cuando acepto la otra oferta p2p') do
  @response = aceptar_oferta(@id_otra_oferta)
end

Entonces('se me comunica el correo del comprador') do
  mail_del_comprador = JSON.parse(@response.body)['mail']
  expect(mail_del_comprador).to eq @email
end

Entonces('la publicacion esta en estado “Vendido”') do
  header = {'ID_TELEGRAM' => @id_telegram}
  respuesta = Faraday.get(listar_mis_publicaciones_url, nil, header)
  publicaciones = JSON.parse(respuesta.body)
  publicacion = publicaciones.find { |pub| pub['id'] == @id_publicacion }
  expect(publicacion['estado']).to eq 'Vendido'
end

def crear_oferta_p2p(email)
  nombre = 'test'
  id_telegram = '01010101'
  body = {nombre: nombre, mail: email, id_telegram: id_telegram}.to_json

  Faraday.post(crear_usuario_url, body, header)
  respuesta = realizar_oferta(id_telegram, 200_000)
  JSON.parse(respuesta.body)['id']
end

def aceptar_oferta(id)
  body = {estado: 'aceptada'}.to_json
  Faraday.patch(aceptar_oferta_url(id), body, header)
end

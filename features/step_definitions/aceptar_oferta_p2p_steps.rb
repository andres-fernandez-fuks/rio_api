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
  @ofertas ||= {}
  @ofertas[@email] = @id_oferta
end

Dado('que hay otra oferta p2p') do
  @id_otra_oferta = crear_oferta_p2p('otro_oferente@test.com')
end

Dado('que acepto la primer oferta p2p') do
  @response = aceptar_oferta(@id_oferta)
end

Cuando('acepto la otra oferta p2p') do
  @response = aceptar_oferta(@id_otra_oferta)
end

Entonces('se me comunica el correo del comprador') do
  mail_del_comprador = JSON.parse(@response.body)['mail']
  expect(mail_del_comprador).to eq @email
end

Entonces('la publicacion esta en estado {string}') do |estado|
  header = {'ID_TELEGRAM' => @id_telegram}
  respuesta = Faraday.get(listar_mis_publicaciones_url, nil, header)
  publicaciones = JSON.parse(respuesta.body)
  publicacion = publicaciones.find { |pub| pub['id'] == @id_publicacion }
  expect(publicacion['estado']).to eq estado
end

Entonces('se levanta un error de que la publicación ya fue vendida') do
  expect(@response.status).to eq 400
  mensaje_error = JSON(@response.body)['error']
  mensaje_esperado = JSON({ :error => 'La publicación ya fue vendida' }.to_json)['error']
  expect(mensaje_error).to eq(mensaje_esperado)
end

Entonces('la otra oferta p2p no fue aceptada') do
  header = {'ID_TELEGRAM' => @id_telegram}
  respuesta = Faraday.get(listar_ofertas_de_publicacion_url(@id_publicacion), nil, header)
  ofertas = JSON.parse(respuesta.body)
  otra_oferta = ofertas.find { |oferta| oferta['id'] == @id_otra_oferta }
  expect(otra_oferta['estado']).not_to be nil
  expect(otra_oferta['estado']).not_to eq 'Aceptada'
end

def crear_oferta_p2p(email)
  nombre = 'test'
  id_telegram = email
  body = {nombre: nombre, mail: email, id_telegram: id_telegram}.to_json

  Faraday.post(crear_usuario_url, body, header)
  respuesta = realizar_oferta(id_telegram, 200_000)
  JSON.parse(respuesta.body)['id']
end

def aceptar_oferta(id)
  body = {estado: 'aceptada'}.to_json
  Faraday.patch(aceptar_oferta_url(id), body, header)
end

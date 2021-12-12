Dado('que existe una publicación P2P activa') do
  registrar_un_usuario
  @id_publicacion = JSON(publicar_auto.body)['id']
  id_oferta = JSON(enviar_informe.body)['id']
  rechazar_oferta(id_oferta)
end

Dado('que existe una publicación P2P vendida') do
  registrar_un_usuario
  @id_publicacion = JSON(publicar_auto.body)['id']
  id_oferta = JSON(enviar_informe.body)['id']
  rechazar_oferta(id_oferta)
  id_oferta = JSON(realizar_oferta(@id_telegram, 15_000).body)['id']
  aceptar_oferta(id_oferta)
end

Dado('ya se realizó una oferta por esa publicación') do
  registrar_un_usuario
  JSON(realizar_oferta(@id_telegram, 15_000).body)['id']
end

Cuando('creo una oferta sobre esa publicación') do
  @precio = 15_000
  @response = realizar_oferta(@id_telegram, @precio)
end

Entonces('la oferta se crea correctamente') do
  respuesta = JSON.parse(@response.body)
  expect(respuesta['monto']).to eq @precio
  expect(respuesta['id_publicacion']).to eq @id_publicacion
end

Entonces('se devuelve un error y la oferta no se crea') do
  expect(@response.status).to eq 409
  expect(JSON(@response.body)['error']).to eq 'La publicación ya fue vendida'
end

Entonces('ambas ofertas quedan guardadas') do
  header = {'ID_TELEGRAM' => @id_usuario_vendedor}
  response = Faraday.get(listar_ofertas_de_publicacion_url(@id_publicacion), nil, header)
  cant_ofertas_p2p = JSON.parse(response.body).length - 1 # se resta la oferta rechazada de fiubak
  expect(cant_ofertas_p2p).to eq 2
end

def registrar_un_usuario
  body_registro = {nombre: 'un nombre', mail: 'otroejemplo@gmail.com', id_telegram: '123'}.to_json
  Faraday.post(crear_usuario_url, body_registro, header)
end

def publicar_auto
  @id_usuario_vendedor = '123'
  body_publicacion = {patente: 'AAA000', marca: 'VW', modelo: 'Golf', anio: 2015, precio: 10_000, id_telegram: @id_usuario_vendedor}.to_json
  Faraday.post(crear_publicacion_url, body_publicacion, header)
end

def enviar_informe
  Faraday.post(informe_de_cotizacion_url(@id_publicacion), {precio: 70_000}.to_json)
end

def rechazar_oferta(id_oferta)
  Faraday.patch(rechazar_oferta_url(id_oferta), {estado: 'rechazada'}.to_json)
end

def realizar_oferta(id_telegram, precio)
  body = {precio: precio}.to_json
  header = {'ID_TELEGRAM' => id_telegram}
  Faraday.post(realizar_oferta_url(@id_publicacion), body, header)
end

def aceptar_oferta(id_oferta)
  Faraday.patch(aceptar_oferta_url(id_oferta), {estado: 'aceptada'}.to_json)
end

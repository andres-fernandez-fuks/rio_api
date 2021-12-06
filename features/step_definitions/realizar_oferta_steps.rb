Dado('que existe una publicación P2P activa') do
  registrar_un_usuario
  @id_publicacion = JSON(publicar_auto.body)['id']
  id_oferta = JSON(enviar_informe.body)['id']
  rechazar_oferta(id_oferta)
end

Cuando('creo una oferta sobre esa publicación') do
  @precio = 15_000
  body = {precio: @precio}.to_json
  header = {'ID_TELEGRAM' => @id_telegram}
  @response = Faraday.post(realizar_oferta_url(@id_publicacion), body, header)
end

Entonces('la oferta se crea correctamente') do
  respuesta = JSON.parse(@response.body)
  expect(respuesta['monto']).to eq @precio
  expect(respuesta['id_publicacion']).to eq @id_publicacion
end

def registrar_un_usuario
  body_registro = {nombre: 'un nombre', mail: 'otroejemplo@gmail.com', id_telegram: '123'}.to_json
  Faraday.post(crear_usuario_url, body_registro, header)
end

def publicar_auto
  body_publicacion = {patente: 'AAA000', marca: 'VW', modelo: 'Golf', anio: 2015, precio: 10_000, id_telegram: '123'}.to_json
  Faraday.post(crear_publicacion_url, body_publicacion, header)
end

def enviar_informe
  Faraday.post(informe_de_cotizacion_url(@id_publicacion), {precio: 70_000}.to_json)
end

def rechazar_oferta(id_oferta)
  Faraday.patch(rechazar_oferta_url(id_oferta), {estado: 'rechazada'}.to_json)
end

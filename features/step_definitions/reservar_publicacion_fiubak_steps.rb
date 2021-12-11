Dado('hay	una publicación activa de tipo fiubak') do
  body_registro = {nombre: 'un nombre', mail: 'otroejemplo3@gmail.com', id_telegram: '123407'}.to_json
  Faraday.post(crear_usuario_url, body_registro, header)
  body_publicacion = {patente: 'ASD123', marca: 'VW', modelo: 'Suran', anio: 2133, precio: 500_000, id_telegram: '123407'}.to_json
  response = Faraday.post(crear_publicacion_url, body_publicacion, header)
  @id_publicacion = JSON(response.body)['id']
  response = Faraday.post(informe_de_cotizacion_url(@id_publicacion), {precio: 70_000}.to_json)
  id_oferta = JSON(response.body)['id']
  body = {estado: 'aceptada'}.to_json
  @response = Faraday.patch(aceptar_oferta_url(id_oferta), body)
end

Cuando('reservo la publicación') do
  pending # Write code here that turns the phrase above into concrete actions
end

Entonces('no aparece al listar publicaciones') do
  publicaciones = JSON(Faraday.get(listar_publicaciones_url).body)
  expect(publicaciones.length).to eq 0
end

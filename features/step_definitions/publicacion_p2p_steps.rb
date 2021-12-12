Dado('que existe una publicación cotizada') do
  id_telegram = '123'
  mail = 'fakemail@gmail.com'
  @body = {nombre: @nombre, mail: mail, id_telegram: id_telegram}.to_json
  Faraday.post(crear_usuario_url, @body, header)
  body = {patente: '100', marca: 'FORD', modelo: 'A', anio: 2000, precio: 50_000, id_telegram: id_telegram}.to_json
  response = Faraday.post(crear_publicacion_url, body)
  @id_publicacion = JSON(response.body)['id']

  body = {precio: 650_000}.to_json
  response = Faraday.post(informe_de_cotizacion_url(@id_publicacion), body)
  @id_oferta = JSON(response.body)['id']
end

Cuando('se rechaza la oferta de FIUBAK para la publicación') do
  body = {estado: 'rechazada'}.to_json
  Faraday.patch(rechazar_oferta_url(@id_oferta), body)
end

Entonces('la publicación pasa a estado activo') do
  response = Faraday.get(listar_publicaciones_url)
  estado = JSON.parse(response.body)[0]['estado']
  expect(estado).to eq('Activo')
end

Entonces('la publicación es de tipo P2P') do
  response = Faraday.get(listar_publicaciones_url)
  tipo = JSON.parse(response.body)[0]['tipo']
  expect(tipo).to eq('p2p')
end

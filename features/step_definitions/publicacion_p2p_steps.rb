Dado('que existe una publicación cotizada') do
  body = {patente: '100', marca: 'FORD', modelo: 'A', anio: 2000, precio: 50_000, id_telegram: '123'}.to_json
  response = Faraday.post(crear_publicacion_url, body, header)
  @id_publicacion = JSON(response.body)['id']

  body = {precio: precio}.to_json
  response = Faraday.post(informe_de_cotizacion_url(@id_publicacion), body)
  @id_oferta = JSON(response.body)['id']
end

Cuando('se rechaza la oferta de FIUBAK para la publicación') do
  body = {estado: 'rechazada'}.to_json
  Faraday.patch(rechazar_oferta_url(@id_oferta), body)
end

Entonces('la publicación pasa a estado activo') do
  response = Faraday.get(consultar_publicacion_url(@id_publicacion))
  estado = JSON.parse(response.body)['estado']
  expect(estado).to eq('activo')
end

Entonces('la publicación es de tipo P2P') do
  response = Faraday.get(consultar_publicacion_url(@id_publicacion))
  tipo = JSON.parse(response.body)['tipo']
  expect(tipo).to eq('p2p')
end

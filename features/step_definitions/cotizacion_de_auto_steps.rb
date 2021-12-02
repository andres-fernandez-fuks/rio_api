Dado('que hay un auto ingresado para cotizar por el usuario con id {string}') do |id_telegram|
  @id_telegram = id_telegram
  body = {nombre: 'nombre', mail: 'mail@gmail.com', id_telegram: id_telegram}.to_json
  Faraday.post(crear_usuario_url, body, header)
  body = {patente: '100', marca: 'FORD', modelo: 'A', anio: 2000, precio: 50_000, id_telegram: @id_telegram}.to_json
  response = Faraday.post(crear_publicacion_url, body, header)
  @id_publicacion = JSON(response.body)['id']
end

Dado('que recibo un informe de cotizacion para el auto publicado con un precio de {int}') do |precio|
  body = {precio: precio}.to_json
  @response = Faraday.post(informe_de_cotizacion_url(@id_publicacion), body)
end

Entonces('la cotización del auto publicado es 700000') do
  expect(@response.status).to be 200
  @id_oferta = JSON(@response.body)['id']
  expect(JSON(@response.body)['id_publicacion']).to eq @id_publicacion
  expect(JSON(@response.body)['precio']).to eq 70_000
end

Entonces('se activa la publicación con el precio de la cotización para el auto, visible sólo para el usuario con id {int}') do |_id_telegram|
  header = {'ID_TELEGRAM' => @id_telegram}
  @response = Faraday.get(listar_mis_ofertas_url, nil, header)
  id_oferta_encontrada = JSON(@response.body)[0]['id']
  expect(@id_oferta).to eq id_oferta_encontrada
end

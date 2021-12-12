Dado('que hay un auto ingresado para cotizar por el usuario con id {string}') do |id_telegram|
  Faraday.post(reset_url)
  @id_telegram = id_telegram
  body = {nombre: 'nombre', mail: 'mail@gmail.com', id_telegram: id_telegram}.to_json
  Faraday.post(crear_usuario_url, body, header)
  body = {patente: '100', marca: 'FORD', modelo: 'A', anio: 2000, precio: 50_000, id_telegram: @id_telegram}.to_json
  response = Faraday.post(crear_publicacion_url, body, header)
  @id_publicacion = JSON(response.body)['id']
end

Cuando('recibo un informe de cotizacion para el auto publicado') do
  body = {precio: 10_000}.to_json
  @response = Faraday.post(informe_de_cotizacion_url(@id_publicacion), body)
end

Entonces('el auto se cotiza correctamente') do
  expect(@response.status).to be 200
  @id_oferta = JSON(@response.body)['id']
  expect(JSON(@response.body)['id_publicacion']).to eq @id_publicacion
  expect(JSON(@response.body)['oferente']).to eq 'fiubak'
end

Entonces('obtiene la oferta para el auto, visible sólo para el usuario con id {int}') do |_id_telegram|
  header = {'ID_TELEGRAM' => @id_telegram}
  @response = Faraday.get(listar_ofertas_de_publicacion_url(@id_publicacion), nil, header)
  id_oferta_encontrada = JSON(@response.body)[0]['id']
  expect(@id_oferta).to eq id_oferta_encontrada
end

Dado('que se ingresó un auto del año {int}') do |anio|
  Faraday.post(reset_url)
  @id_telegram = '12345678'
  body = {nombre: 'nombre', mail: 'mail@gmail.com', id_telegram: @id_telegram}.to_json
  Faraday.post(crear_usuario_url, body, header)
  body = {patente: '100', marca: 'FORD', modelo: 'A', anio: anio, precio: 50_000, id_telegram: @id_telegram}.to_json
  response = Faraday.post(crear_publicacion_url, body, header)
  @id_publicacion = JSON(response.body)['id']
end

Cuando('se recibe un informe sin fallas') do
  @body_informe = {}
end

Entonces('se realiza una oferta de fiubak por {int}') do |monto|
  Faraday.post(informe_de_cotizacion_url(@id_publicacion), @body_informe.to_json)
  header = {'ID_TELEGRAM' => @id_telegram}
  respuesta = Faraday.get(listar_ofertas_de_publicacion_url(@id_publicacion), nil, header)
  ofertas = JSON(respuesta.body)
  expect(ofertas.length).to eq 1
  expect(ofertas[0]['monto']).to eq monto
end

Cuando('se recibe un informe con falla de tipo {string} con gravedad {string}') do |tipo, gravedad|
  @body_informe = {}
  @body_informe[tipo] = gravedad
end

Cuando('falla de tipo {string} con gravedad {string}') do |tipo, gravedad|
  @body_informe[tipo] = gravedad
end

Entonces('se cancela la publicación.') do
  respuesta_cotizacion = Faraday.post(informe_de_cotizacion_url(@id_publicacion), @body_informe.to_json)
  expect(respuesta_cotizacion.status).to eq 204
  header = {'ID_TELEGRAM' => @id_telegram}
  respuesta = Faraday.get(listar_mis_publicaciones_url, nil, header)
  publicaciones = JSON(respuesta.body)
  publicacion = publicaciones.find { |pub| pub['id'] == @id_publicacion }
  expect(publicacion['estado']).to eq 'Cancelado'
end

Dado('que no tengo publicaciones') do
end

Cuando('consulto por mis publicaciones') do
  header = {'ID_TELEGRAM' => @id_telegram}
  @response = Faraday.get(listar_mis_publicaciones_url, nil, header)
end

Dado('que tengo un auto publicado patente {string}, marca {string}, modelo {string}, año {int} y precio {float}') do |patente, marca, modelo, anio, precio|
  @body = {patente: patente, marca: marca, modelo: modelo, anio: anio, precio: precio, id_telegram: @id_telegram}.to_json
  @response = Faraday.post(crear_publicacion_url, @body, header)
  @id_publicacion = JSON(@response.body)['id']
  @precio = precio
end

Dado('mi publicación todavía está en revisión') do
  @estado_publicacion = 'En revisión'
end

Dado('mi publicación ya fue cotizada') do
  body = {precio: 10_000}.to_json
  Faraday.post(informe_de_cotizacion_url(@id_publicacion), body)
  @estado_publicacion = 'Cotizado'
end

Entonces('los datos de mi publicación son los correctos') do
  expect(JSON(@response.body)[0]['id']).to eq @id_publicacion
  expect(JSON(@response.body)[0]['precio']).to eq @precio
  expect(JSON(@response.body)[0]['estado']).to eq @estado_publicacion
end

# rubocop:disable all
Dado('que hay un auto publicado patente {string}, marca {string}, modelo {string}, año {int} y precio {float} por el usuario con id_telegram {string}') do |patente, marca, modelo, anio, precio, otro_id_telegram|
  body = {nombre: "otroUsuario", mail: "otroMail", id_telegram:otro_id_telegram}.to_json
  Faraday.post(crear_usuario_url, body, header)
  body = {patente: patente, marca: marca, modelo: modelo, anio: anio, precio: precio, id_telegram: otro_id_telegram}.to_json
  @response = Faraday.post(crear_publicacion_url, body, header)
  @id_publicacion = JSON(@response.body)['id']
  @precio = precio
end

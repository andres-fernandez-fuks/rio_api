Dado('que no tengo publicaciones') do
end

Cuando('consulto por mis publicaciones') do
  header = {'ID_TELEGRAM' => @id_telegram}
  @response = Faraday.get(listar_mis_publicaciones_url, nil, header)
end

Dado('que tengo un auto publicado patente {string} marca {string}, modelo {string}, anio {int} y precio {float}') do |patente, marca, modelo, anio, precio|
  @body = {patente: patente, marca: marca, modelo: modelo, anio: anio, precio: precio, id_telegram: @id_telegram}.to_json
  @response = Faraday.post(crear_publicacion_url, @body, header)
  @id_publicacion = JSON(@response.body)['id']
  @precio = precio
end

Entonces('los datos de mi publicación son los correctos') do
  expect(JSON(@response.body)[0]['id']).to eq @id_publicacion
  expect(JSON(@response.body)[0]['precio']).to eq @precio
end

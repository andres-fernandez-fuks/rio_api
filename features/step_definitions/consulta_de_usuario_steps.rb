Dado('que mi id_telegram es {string}') do |id_telegram|
  @id_telegram = id_telegram
end

Dado('que no estoy registrado como usuario') do
  Faraday.post(reset_url)
end

Cuando('consulto si soy un usuario registrado') do
  header = {'ID_TELEGRAM' => @id_telegram}
  @response = Faraday.get(consultar_usuario_url, nil, header)
end

Entonces('recibo un error de usuario no registrado') do
  expect(@response.status).to be 404
  expect(JSON(@response.body)['error']).to eq 'Usuario no registrado'
end

Dado('que estoy registrado como usuario') do
  Faraday.post(reset_url)
  @nombre = 'un nombre'
  @mail = 'ejemplo@gmail.com'
  @body = {nombre: @nombre, mail: @mail, id_telegram: @id_telegram}.to_json
  Faraday.post(crear_usuario_url, @body, header)
end

Entonces('recibo mi información de usuario') do
  expect(@response.status).to be 200
  expect(JSON(@response.body)['nombre']).to eq @nombre
  expect(JSON(@response.body)['mail']).to eq @mail
  expect(JSON(@response.body)['id_telegram']).to eq @id_telegram
end

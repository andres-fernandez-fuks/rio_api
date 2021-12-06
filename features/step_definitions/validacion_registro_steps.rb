Dado('que hay un usuario registrado con el mail {string}') do |mail|
  body = {nombre: 'nombre', mail: mail, id_telegram: '1234'}.to_json
  Faraday.post(crear_usuario_url, body, header)
end

Cuando('otro usuario se registra con el mail {string}') do |mail|
  body = {nombre: 'nombre', mail: mail, id_telegram: '1234'}.to_json
  @response = Faraday.post(crear_usuario_url, body, header)
end

Entonces('se retorna un error con el mensaje {string}') do |mensaje|
  expect(JSON(@response.body)['error']).to eq mensaje
end

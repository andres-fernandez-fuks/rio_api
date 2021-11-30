require 'byebug'
Dado('que no hay ningun usuario registrado') do
  Faraday.post(reset_url)
end

Cuando('registro un usuario con nombre {string}, mail {string} y id_telegram {string}') do |nombre, mail, id_telegram|
  @nombre = nombre
  @mail = mail
  @body = {nombre: nombre, mail: mail, id_telegram: id_telegram}.to_json
  @response = Faraday.post(crear_usuario_url, @body, header)
end

Entonces('el usuario se registra correctamente') do
  expect(@response.status).to be 201
  expect(JSON(@response.body)['nombre']).to eq @nombre
  expect(JSON(@response.body)['mail']).to eq @mail
end

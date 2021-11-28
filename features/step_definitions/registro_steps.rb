Dado('que no hay ningun usuario registrado') do
  UsuariosRepository.new.delete_all
end

Cuando('registro un usuario con nombre {string}, mail {string} y id_telegram {string}') do |nombre, mail, id_telegram|
  @body = {nombre: nombre, mail: mail, id_telegram: id_telegram}.to_json
  @response = Faraday.post(crear_usuario_url, @body, header)
end

Entonces('el usuario se registra correctamente') do
  expect(@response.status).to be 201
end
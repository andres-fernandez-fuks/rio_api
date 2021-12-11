Dado('hay	una publicación activa de tipo fiubak') do
  body_registro = {nombre: 'un nombre', mail: 'otroejemplo3@gmail.com', id_telegram: '123407'}.to_json
  Faraday.post(crear_usuario_url, body_registro, header)
  crear_publicacion_fiubak('AAA123', 'X', 'FAR', 2017, 800_000, '123407')

  header = {'ID_TELEGRAM' => 'id-fiubak'}
  respuesta = Faraday.get(listar_mis_publicaciones_url, nil, header)
  @id_publicacion = JSON(respuesta.body)[0]['id']
  @id_telegram = 'id-fiubak' # IMPORTANTE para verificar si esta en estado reservado luego
end

Cuando('reservo la publicación') do
  response = Faraday.post(reservar_publicacion_url(@id_publicacion))
  expect(response.status).to eq 200
end

Entonces('no aparece al listar publicaciones') do
  publicaciones = JSON(Faraday.get(listar_publicaciones_url).body)
  expect(publicaciones.length).to eq 0
end

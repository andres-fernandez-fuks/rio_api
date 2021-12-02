Dado('que tengo una oferta a un vendedor por {float}') do |precio|
  body = {nombre: 'nombre', mail: 'mail@gmail.com', id_telegram: '123'}.to_json
  Faraday.post(crear_usuario_url, body, header)
  @datos_publicacion = {patente: 'ASD100', marca: 'FORD', modelo: 'A', anio: 2000, precio: precio, id_telegram: '123'}
  response = Faraday.post(crear_publicacion_url, @datos_publicacion.to_json, header)
  id_publicacion = JSON(response.body)['id']
  response = Faraday.post(informe_de_cotizacion_url(id_publicacion), nil)
  @id_oferta = JSON.parse(response.body)['id_oferta']
end

Cuando('el vendedor la acepta') do
  body = {estado: 'aceptada'}.to_json
  @response = Faraday.patch(aceptar_oferta_url(@id_oferta), body, header)
end

Entonces('publico el auto con un incremento del {int}% a un precio de {float}') do |porcentaje, precio|
  @datos_publicacion['precio'] = @datos_publicacion['precio'] * (porcentaje / 100)
  response = Faraday.post(crear_publicacion_url, @datos_publicacion.to_json, header)
  expect(JSON.parse(response.body)['precio']).to eq precio
end
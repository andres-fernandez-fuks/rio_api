Dado('que tengo una publicación p2p por un auto patente {string}, marca {string}, modelo {string}, año {int} y precio {float}') do |patente, marca, modelo, anio, precio|
  body_registro = {patente: patente, marca: marca, modelo: modelo, anio: anio, precio: precio, id_telegram: @id_telegram}.to_json
  response = Faraday.post(crear_publicacion_url, body_registro, header)
  @id_publicacion = JSON(response.body)['id']
  response = Faraday.post(informe_de_cotizacion_url(@id_publicacion), {precio: 70_000}.to_json)
  id_oferta = JSON(response.body)['id']
  Faraday.patch(rechazar_oferta_url(id_oferta), {estado: 'rechazada'}.to_json)
end

Dado('hay una oferta p2p por 2000000 para la publicación') do
end

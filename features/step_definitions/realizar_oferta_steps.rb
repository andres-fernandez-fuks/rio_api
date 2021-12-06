Dado('que existe una publicación P2P activa') do
  body_registro = {patente: 'AAA000', marca: 'VW', modelo: 'Golf', anio: 2015, precio: 10_000, id_telegram: '123'}.to_json
  response = Faraday.post(crear_publicacion_url, body_registro, header)
  @id_publicacion = JSON(response.body)['id']
  response = Faraday.post(informe_de_cotizacion_url(@id_publicacion), {precio: 70_000}.to_json)
  id_oferta = JSON(response.body)['id']
  Faraday.patch(rechazar_oferta_url(id_oferta), {estado: 'rechazada'}.to_json)
end

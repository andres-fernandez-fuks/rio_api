Dado('que existe una oferta de FIUBAK para la publicacion') do
  header = { 'ID_TELEGRAM' => @id_telegram }
  Faraday.post(informe_de_cotizacion_url(@id_publicacion), {}.to_json)
  respuesta_ofertas = Faraday.get(listar_ofertas_de_publicacion_url(@id_publicacion), nil, header)
  ofertas = JSON(respuesta_ofertas.body)
  @id_oferta = ofertas[0]['id']
  @monto = ofertas[0]['monto']
end

Cuando('el usuario vendedor acepta la oferta de FIUBAK') do
  body = {estado: 'aceptada'}.to_json
  @response = Faraday.patch(aceptar_oferta_url(@id_oferta), body)
end

Entonces('se crea una nueva publicación de FIUBAK con el valor de la oferta aumentado en 30%') do
  @response = Faraday.get(listar_publicaciones_url)
  respuesta = JSON.parse(@response.body)
  expect(respuesta[0]['precio']).to eq @monto * 1.3
end

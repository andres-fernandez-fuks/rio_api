Dado('que recibo un informe de cotizacion para el auto publicado') do
  body = {precio: 70_000}.to_json
  @response = Faraday.post(informe_de_cotizacion_url(@id_publicacion), body)
  @id_oferta = JSON(@response.body)['id']
end

Cuando('acepto la oferta') do
  body = {estado: 'aceptada'}.to_json
  @response = Faraday.patch(aceptar_oferta_url(@id_oferta), body, header)
end

Entonces('la oferta está con estado {string}') do |_string|
  expect(@response.status).to be 200
  expect(JSON.parse(@response.body)['estado']['id']).to eq EstadoAceptada.new.id
end

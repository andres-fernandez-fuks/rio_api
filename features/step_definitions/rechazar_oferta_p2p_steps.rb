Cuando('rechazo la oferta') do
  body = {estado: 'rechazada'}.to_json
  @response = Faraday.patch(aceptar_oferta_url(@id_oferta), body, header)
end

Entonces('la oferta no fue aceptada') do
  expect(JSON(@response.body)['estado']).to eq 'Rechazada'
end

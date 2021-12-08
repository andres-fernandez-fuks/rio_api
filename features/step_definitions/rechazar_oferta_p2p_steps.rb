Cuando('rechazo la oferta') do
  body = {estado: 'rechazada'}.to_json
  @response = Faraday.patch(aceptar_oferta_url(@id_oferta), body, header)
end

Entonces('la oferta no fue aceptada') do
  expect(JSON(@response.body)['estado']).to eq 'Rechazada'
end

Cuando('rechazo la oferta del usuario con email {string}') do |mail|
  id_oferta = @ofertas[mail]
  body = JSON(rechazar_oferta(id_oferta).body)
  @ofertas_rechazadas ||= {}
  @ofertas_rechazadas[mail] = body
end

Entonces('la oferta del usuario con email {string} no fue aceptada') do |mail|
  expect(@ofertas_rechazadas[mail]['estado']).to eq 'Rechazada'
end

Cuando('acepto la oferta del usuario con email {string}') do |mail|
  id_oferta = @ofertas[mail]
  @oferta_aceptada = JSON(aceptar_oferta(id_oferta).body)
end

Entonces('se me comunica el correo del comprador que es {string}') do |mail|
  expect(@oferta_aceptada['mail']).to eq mail
end

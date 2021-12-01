Dado('que hay un auto ingresado para cotizar por el usuario con id {string}') do |id_telegram|
  @id_telegram = id_telegram
end

Dado('que recibo un informe de cotizacion para el auto de la publicacion con id unico {int}') do |id_publicacion|
  @id_publicacion = id_publicacion
end

Cuando('cotizo el auto') do
  header = {'ID_TELEGRAM' => @id_telegram}
  @response = Faraday.get(informe_de_cotizacion_url, nil, header)
end

Entonces('la cotización del auto de la publicacion con id unico {int} es 700000') do |_id_publicacion|
  expect(@response.status).to be 200
  expect(JSON(@response.body)['precio']).to eq 70_000
end

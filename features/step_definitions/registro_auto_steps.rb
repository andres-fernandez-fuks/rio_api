Dado('no hay autos publicados') do
  Faraday.post(reset_url)
end

Cuando('registro una intención de venta para el auto {string},{string},{string},{int},{float}') do |patente, marca, modelo, anio, precio|
  @body = {patente: patente, marca: marca, modelo: modelo, anio: anio, precio: precio, id_telegram: @id_telegram}.to_json
  Faraday.post(crear_publicacion_url, @body, header)
end

Entonces('la intención de venta se genera correctamente') do
  expect(response.status).to eq 201
end

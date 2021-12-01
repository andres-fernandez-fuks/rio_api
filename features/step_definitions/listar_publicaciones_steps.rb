Dado('hay {int} autos publicados') do |cant_autos|
  (0..cant_autos).each do |i|
    # Falta asegurarse que las publicaciones creadas queden en estado activo
    body = {patente: "AAA12#{i}", marca: 'VW', modelo: 'Suran', anio: 2017, precio: 600_000, id_telegram: '123'}.to_json
    Faraday.post(crear_publicacion_url, body)
  end
end

Cuando('consulto por todas las publicaciones') do
  @response = Faraday.get(listar_publicaciones_url)
end

Entonces('recibo {int} publicaciones') do |cant_autos|
  expect(JSON.parse(@response.body).length).to eq cant_autos
end

Entonces('tiene los datos correspondientes') do
  pending # Write code here that turns the phrase above into concrete actions
end

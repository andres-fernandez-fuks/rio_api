TEST_ID_TELEGRAM = '555'.freeze
MONTO_OFRECIDO_FIUBAK = 45_000

Dado('que existe una publicación') do
  Faraday.post(reset_url)
  @id_telegram = TEST_ID_TELEGRAM
  body = {nombre: 'nombre', mail: 'mail@gmail.com', id_telegram: @id_telegram}.to_json
  Faraday.post(crear_usuario_url, body, header)
  body = {patente: '100', marca: 'FORD', modelo: 'A', anio: 2000, precio: 50_000, id_telegram: @id_telegram}.to_json
  response = Faraday.post(crear_publicacion_url, body, header)
  @id_publicacion = JSON(response.body)['id']
end

Dado('la publicación fue cotizada por FIUBAK') do
  body = {precio: MONTO_OFRECIDO_FIUBAK}.to_json
  Faraday.post(informe_de_cotizacion_url(@id_publicacion), body)
end

Cuando('consulto por las ofertas de la publicación') do
  header = {'ID_TELEGRAM' => @id_telegram}
  @response = Faraday.get(listar_ofertas_de_publicacion_url(@id_publicacion), nil, header)
end

Entonces('se devuelve la oferta de FIUBAK con el monto ofrecido y el estado “Pendiente”') do
  expect(JSON(@response.body).length).to eq 1
  expect(JSON(@response.body)[0]['oferente']).to eq 'fiubak'
  expect(JSON(@response.body)[0]['estado']).to eq EstadoPendiente.new.id
end

Entonces('se devuelve la oferta de FIUBAK con el monto cotizado y el estado {string}') do |estado|
  oferta_fiubak = JSON(@response.body).find { |oferta| oferta['oferente'] == 'fiubak' }
  expect(oferta_fiubak['oferente']).to eq 'fiubak'
  expect(oferta_fiubak['estado']).to eq estado
end

Entonces('se devuelve la oferta p2p con el monto ofrecido y el estado {string}') do |estado|
  oferta_p2p = JSON(@response.body).find { |oferta| oferta['oferente'] != 'fiubak' }
  expect(oferta_p2p['estado']).to eq estado
end

Entonces('se devuelven {int} ofertas') do |ofertas|
  expect(JSON(@response.body).length).to eq ofertas
end

Dado('hay {int} autos publicados') do |cant_autos|
  Faraday.post(reset_url)
  registrar_usuario('123')
  (1..cant_autos).each do |i|
    crear_publicacion_activa("AAA12#{i}", 'VW', 'Suran', 2010 + i, 600_000)
  end
end

Cuando('consulto por todas las publicaciones') do
  @response = Faraday.get(listar_publicaciones_url)
end

Entonces('recibo {int} publicaciones') do |cant_autos|
  expect(JSON.parse(@response.body).length).to eq cant_autos
end

When(/^hay que hay 1 auto publicado con patente "([^"]*)", marca "([^"]*)", modelo "([^"]*)", precio (\d+) y anio (\d+)$/) do |patente, marca, modelo, precio, anio|
  Faraday.post(reset_url)
  registrar_usuario('123')
  @precio_publicacion = precio
  crear_publicacion_activa(patente, marca, modelo, anio, precio)
end

Entonces('tiene los datos correspondientes') do
  respuesta = JSON.parse(@response.body)
  expect(respuesta[0]['precio'].to_i).to eq @precio_publicacion.to_i
end

def registrar_usuario(id_telegram)
  body = {nombre: 'Nombre', mail: 'ejemplo@gmail.com', id_telegram: id_telegram}.to_json
  respuesta = Faraday.post(crear_usuario_url, body, header)
  JSON.parse(respuesta.body)['id']
end

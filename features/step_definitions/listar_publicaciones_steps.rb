Dado('hay {int} autos publicados') do |cant_autos|
  Faraday.post(reset_url)
  registrar_usuario('123')
  (1..cant_autos).each do |_i|
    # body = {patente: "AAA12#{i}", marca: 'VW', modelo: 'Suran', anio: 2017, precio: 600_000, id_telegram: '123'}.to_json
    # response = Faraday.post(crear_publicacion_url, body)
    # --- Activar ---
    usuario = Persistence::Repositories::RepositorioUsuarios.new.buscar_por_id_telegram('123')
    publicacion = Publicacion.new(30_000, usuario)
    publicacion.activar
    Persistence::Repositories::RepositorioPublicaciones.new.save(publicacion)
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
  @datos_publicacion = {patente: patente, marca: marca, modelo: modelo, anio: anio, precio: precio, id_telegram: '123'}
  # response = Faraday.post(crear_publicacion_url, @datos_publicacion.to_json)
  # Activar
  usuario = Persistence::Repositories::RepositorioUsuarios.new.buscar_por_id_telegram('123')
  publicacion = Publicacion.new(precio, usuario)
  publicacion.activar
  Persistence::Repositories::RepositorioPublicaciones.new.save(publicacion)
end

Entonces('tiene los datos correspondientes') do
  respuesta = JSON.parse(@response.body)
  expect(respuesta[0]['precio']).to eq @datos_publicacion[:precio]
end

def registrar_usuario(id_telegram)
  body = {nombre: 'Nombre', mail: 'ejemplo@gmail.com', id_telegram: id_telegram}.to_json
  respuesta = Faraday.post(crear_usuario_url, body, header)
  JSON.parse(respuesta.body)['id']
end

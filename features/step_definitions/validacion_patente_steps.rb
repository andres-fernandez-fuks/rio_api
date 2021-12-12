Dado('que existe una publicación "Cancelada" para el auto con patente {string}') do |patente|
  crear_publicacion_cancelada(patente)
end

Dado('que existe una publicación "Reservada" para el auto con patente {string}') do |patente|
  crear_publicacion_reservada(patente)
end

Dado('que existe una publicación "Vendida" para el auto con patente {string}') do |patente|
  crear_publicacion_vendida(patente)
end

Dado('que existe una publicación “En revisión" para el auto con patente {string}') do |patente|
  crear_publicacion_en_revision(patente)
end

Cuando('creo una publicación para el auto con patente {string}') do |patente|
  @body = {patente: patente, marca: 'VW', modelo: 'Bus', anio: 1980, precio: 10_000, id_telegram: @id_telegram}.to_json
  @response = Faraday.post(crear_publicacion_url, @body, header)
end

Entonces('la publicación se crea correctamente') do
  expect(@response.status).to be 201
end

Entonces('recibo un error') do
  expect(@response.status).to be 409
end

def crear_publicacion_cancelada(patente)
  @id_publicacion = JSON.parse(crear_publicacion(patente).body)['id']
  body_informe = {'estetica' => 'Grave'}.to_json
  Faraday.post(informe_de_cotizacion_url(@id_publicacion), body_informe)
end

def crear_publicacion_reservada(patente)
  response = crear_publicacion_fiubak(patente, 'VW', 'Bus', 2015, 10_000, @id_telegram)
  @id_publicacion = JSON.parse(response.body)['id']
  Faraday.post(reservar_publicacion_url(@id_publicacion))
end

def crear_publicacion_vendida(patente)
  response = crear_publicacion_p2p(patente, 'VW', 'Bus', 2015, 10_000, @id_telegram)
  @id_publicacion = JSON.parse(response.body)['id']
  aceptar_oferta(@id_oferta)
end

def crear_publicacion_en_revision(patente)
  body_auto = {patente: patente, marca: 'VW', modelo: 'Bus', anio: 1980, precio: 10_000, id_telegram: @id_telegram}.to_json
  response = Faraday.post(crear_publicacion_url, body_auto, header)
  @id_publicacion = response['id']
end

def crear_oferta
  response = Faraday.post(realizar_oferta_url(@id_publicacion), 15_000)
  @id_oferta = response['id']
end

def crear_publicacion(patente)
  body_auto = {patente: patente, marca: 'VW', modelo: 'Bus', anio: 1980, precio: 10_000, id_telegram: @id_telegram}.to_json
  Faraday.post(crear_publicacion_url, body_auto, header)
end

Dado('que existe una publicación "Cancelada" para el auto con patente {string}') do |patente|
  crear_publicacion_cancelada(patente)
end

Dado('que existe una publicación "Reservada" para el auto con patente {string}') do |patente|
  crear_publicacion_reservada(patente)
end

Cuando('creo una publicación para el auto con patente {string}') do |patente|
  @body = {patente: patente, marca: 'VW', modelo: 'Bus', anio: 1980, precio: 10_000, id_telegram: @id_telegram}.to_json
  @response = Faraday.post(crear_publicacion_url, @body, header)
end

Entonces('la publicación se crea correctamente') do
  expect(@response.status).to be 201
end

def crear_publicacion_cancelada(patente)
  registrar_usuario(@id_telegram, 'unmail@gmail.com')
  registrar_auto_defectuoso(patente)
end

def registrar_auto_defectuoso(patente)
  body_auto = {patente: patente, marca: 'VW', modelo: 'Bus', anio: 1980, precio: 10_000, id_telegram: @id_telegram}.to_json
  Faraday.post(crear_publicacion_url, body_auto, header)
  body_informe = {'estetica' => 'Grave'}.to_json
  Faraday.post(informe_de_cotizacion_url(@id_publicacion), body_informe)
end

def crear_publicacion_reservada(patente)
  @response = crear_publicacion_fiubak(patente, 'VW', 'Bus', 2015, 10_000, @id_telegram)
  @id_publicacion = @response['id']
  reservar_auto_fiubak
end

def reservar_auto_fiubak
  Faraday.post(reservar_publicacion_url(@id_publicacion))
end

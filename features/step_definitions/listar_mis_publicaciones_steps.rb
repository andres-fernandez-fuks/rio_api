Dado('que no tengo publicaciones') do
end

Cuando('consulto por mis publicaciones') do
  header = {'ID_TELEGRAM' => @id_telegram}
  @response = Faraday.get(listar_mis_publicaciones_url, nil, header)
end

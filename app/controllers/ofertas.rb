WebTemplate::App.controllers :ofertas, :provides => [:json] do
  patch :create, :map => '/ofertas/:id_oferta' do
    mensaje = params_oferta[:estado]
    if mensaje == 'aceptada'
      oferta = repo_ofertas.find(params[:id_oferta])
      unless oferta
        status 404
        error_oferta_no_encontrada
        return
      end
      begin
        aceptar_oferta(oferta)
        status 204
        oferta_a_json(oferta)
      rescue StandardError => e
        status 500
        {error: e.message}.to_json
      end
    end
  end
end

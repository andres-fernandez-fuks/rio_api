class OfertaAceptada
  attr_reader :oferta, :id_publicacion_fiubak

  def initialize(oferta, id_publicacion_fiubak)
    @oferta = oferta
    @id_publicacion_fiubak = id_publicacion_fiubak
  end
end

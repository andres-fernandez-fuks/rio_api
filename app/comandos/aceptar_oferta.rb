class AceptarOferta
  def self.ejecutar(oferta)
    publicacion = oferta.publicacion
    publicacion.vendida if oferta.fiubak?
    oferta
  end
end

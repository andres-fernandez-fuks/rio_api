require_relative 'comando'
class AceptarOferta < Comando
  def ejecutar(oferta)
    publicacion = oferta.publicacion
    publicacion.vendida if oferta.fiubak?
    publicacion_nueva = Publicacion.new(oferta.monto * 1.3, fiubak, auto_generico)
    publicacion_nueva.activar
    oferta.aceptar
    guardar_cambios(oferta, publicacion, publicacion_nueva)
  end

  private

  def guardar_cambios(oferta, publicacion, publicacion_nueva)
    guardar_publicacion(publicacion_nueva)
    guardar_publicacion(publicacion)
    guardar_oferta(oferta)
  end

  def fiubak
    fiubak = Usuario.new('fiubak', 'fiubak', 'fiubak')
    guardar_usuario(fiubak)
  end

  def auto_generico
    auto_generico = Auto.new('AAA000', 'FORD', 'AMAROK', 2019)
    Persistence::Repositories::RepositorioAutos.new.save(auto_generico)
  end
end

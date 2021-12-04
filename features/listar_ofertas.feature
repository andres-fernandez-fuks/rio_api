#language:es
@wip
Característica: Listar ofertas de una publicacion
  Antecedentes:
    Dado que estoy registrado como usuario

  Escenario: CO1 - Listado con Oferta Fiubak
      Dado que existe una publicación
      Y la publicación fue cotizada por FIUBAK
      Cuando consulto por las ofertas de la publicación
      Entonces se devuelve la oferta de FIUBAK con el monto ofrecido y el estado “Pendiente”

  Escenario: CO2 - Listado de 2 ofertas
      Dado que existe una publicación p2p
      Y hay una oferta p2p para la publicación
      Cuando consulto por las ofertas de la publicación
      Entonces se devuelve la oferta de FIUBA con el monto cotizado y el estado "Rechazada"
      Y se devuelve la oferta p2p con el monto ofrecido y el estado "Pendiente"

  Escenario: CO3 - Listado de ofertas vacío
      Dado que existe una publicación
      Cuando consulto por las ofertas
      Entonces se devuelven 0 ofertas



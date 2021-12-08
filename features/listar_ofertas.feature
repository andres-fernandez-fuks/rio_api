#language:es

Característica: Listar ofertas de una publicacion
  Antecedentes:
      Dado que mi id_telegram es "12345678"
      Y que estoy registrado como usuario

  Escenario: CO1 - Listado con Oferta Fiubak
      Dado que existe una publicación
      Y la publicación fue cotizada por FIUBAK
      Cuando consulto por las ofertas de la publicación
      Entonces se devuelve la oferta de FIUBAK con el monto ofrecido y el estado “Pendiente”

  Escenario: CO2 - Listado de 2 ofertas
      Y que tengo una publicación p2p por un auto patente "AAA000", marca "VW", modelo "Suran", año 2016 y precio 550000
      Y hay una oferta p2p por 2000000 para la publicación del usuario con email "usuario@test.com"
      Cuando consulto por las ofertas de la publicación
      Entonces se devuelve la oferta de FIUBAK con el monto cotizado y el estado "Rechazada"
      Y se devuelve la oferta p2p con el monto ofrecido y el estado "Pendiente"

  Escenario: CO3 - Listado de ofertas vacío
      Dado que existe una publicación
      Cuando consulto por las ofertas de la publicación
      Entonces se devuelven 0 ofertas



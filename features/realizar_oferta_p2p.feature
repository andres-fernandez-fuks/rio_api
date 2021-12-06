#language: es

Característica: Oferta p2p
  Antecedentes:
    Dado que mi id_telegram es "1000"
    Y que estoy registrado como usuario

  Escenario: OP001 - Una oferta sobre una publicación activa se realiza correctamente
    Dado que existe una publicación P2P activa
    Cuando creo una oferta sobre esa publicación
    Entonces la oferta se crea correctamente
  @wip
  Escenario: OP002 - Una oferta sobre una publicación vendida devuelve un error
    Dado que existe una publicación P2P vendida
    Cuando creo una oferta sobre esa publicación
    Entonces se devuelve un error y la oferta no se crea
  @wip
  Escenario: OP003 - Una segunda oferta de otro usuario sobre una publicación activa se realiza correctamente
    Dado que existe una publicación P2P activa
    Y ya se realizó una oferta del usuario con id_telegram “12”
    Cuando creo una oferta del usuario con id_telegram “20” sobre esa publicación
    Entonces la segunda oferta se crea correctamente
  @wip
  Escenario: OP004 - Una segunda oferta del mismo usuario sobre una publicación activa se realiza correctamente
    Dado que existe una publicación P2P activa
    Y ya se realizó una oferta del usuario con id_telegram “12”
    Cuando creo una oferta del usuario con id_telegram “12” sobre esa publicación
    Entonces la oferta se crea correctamente y ambas ofertas quedan guardadas

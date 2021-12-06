#language: es

Característica: Oferta p2p
  Antecedentes:
    Dado que mi id_telegram es "1000"
    Y que estoy registrado como usuario

  Escenario: OP001 - Una oferta sobre una publicación activa se realiza correctamente
    Dado que existe una publicación P2P activa
    Cuando creo una oferta sobre esa publicación
    Entonces la oferta se crea correctamente

  Escenario: OP002 - Una oferta sobre una publicación vendida devuelve un error
    Dado que existe una publicación P2P vendida
    Cuando creo una oferta sobre esa publicación
    Entonces se devuelve un error y la oferta no se crea

  Escenario: OP003 - Una segunda oferta sobre una publicación activa se realiza correctamente
    Dado que existe una publicación P2P activa
    Y ya se realizó una oferta por esa publicación
    Cuando creo una oferta sobre esa publicación
    Entonces la oferta se crea correctamente
    Y ambas ofertas quedan guardadas

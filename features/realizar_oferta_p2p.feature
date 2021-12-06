#language: es
@wip
Característica: Oferta p2p

  Escenario: OP001B - Una oferta sobre una publicación activa se realiza correctamente
    Dado que existe una publicación por la que quiero ofertar
    Cuando escribo el comando /ofertar <id_publicacion>,<monto>
    Y la publicación se encuentra activa
    Entonces el bot me contesta mostrándome el id de la oferta y el monto ofertado

  Escenario: OP002B - Una oferta sobre una publicación vendida no puede realizarse
    Dado que existe una publicación por la que quiero ofertar
    Cuando escribo el comando /ofertar <id_publicacion>,<monto>
    Y la publicación se encuentra vendida
    Entonces el bot me contesta informándome que no se pudo realizar la oferta porque el auto ya fue vendido

  Escenario: OP004B - Una segunda oferta del mismo usuario sobre una publicación activa no se puede realizar

  Dado que existe una publicación por la que quiero ofertar
    Y la publicación se encuentra activa
    Y escribo el comando /ofertar <id_publicacion>,<monto>
    Cuando escribo el comando /ofertar <id_publicacion>,<monto2>
    Entonces el bot me contesta “No se pudo realizar la oferta. Usted ya ofertó por ese auto.”

  Escenario: OP001 - Una oferta sobre una publicación activa se realiza correctamente
    Dado que existe una publicación P2P activa
    Cuando creo una oferta sobre esa publicación
    Entonces la oferta se crea correctamente

  Escenario: OP002 - Una oferta sobre una publicación vendida devuelve un error
    Dado que existe una publicación P2P vendida
    Cuando creo una oferta sobre esa publicación
    Entonces se devuelve un error y la oferta no se crea

  Escenario: OP003 - Una segunda oferta de otro usuario sobre una publicación activa se realiza correctamente
    Dado que existe una publicación P2P activa
    Y ya se realizó una oferta del usuario con id_telegram “12”
    Cuando creo una oferta del usuario con id_telegram “20” sobre esa publicación
    Entonces la segunda oferta se crea correctamente

  Escenario: OP004 - Una segunda oferta del mismo usuario sobre una publicación activa se realiza correctamente
    Dado que existe una publicación P2P activa
    Y ya se realizó una oferta del usuario con id_telegram “12”
    Cuando creo una oferta del usuario con id_telegram “12” sobre esa publicación
    Entonces la oferta se crea correctamente y ambas ofertas quedan guardadas

#language: es

Característica: Rechazar ofertas p2p
  Antecedentes: 
    Dado que mi id_telegram es "12345678"
    Dado que estoy registrado como usuario
    Y que tengo una publicación p2p por un auto patente "AAA000", marca "VW", modelo "Suran", año 2016 y precio 550000
    Y hay una oferta p2p por 2000000 para la publicación del usuario con email "usuario@test.com"

  Escenario: RO001 - Rechazar una oferta P2P
    Cuando rechazo la oferta
    Entonces la oferta no fue aceptada
    Y la publicacion esta en estado "Activo"

  Escenario: RO002 - Rechazar multiples ofertas para la misma publicacion P2P
    Dado hay una oferta p2p por 2000000 para la publicación del usuario con email "usuario2@test.com"
    Cuando rechazo la oferta del usuario con email "usuario@test.com"
    Y rechazo la oferta del usuario con email "usuario2@test.com"
    Entonces la oferta del usuario con email "usuario@test.com" no fue aceptada
    Y la oferta del usuario con email "usuario2@test.com" no fue aceptada
    Y la publicacion esta en estado "Activo"

  Escenario: RO003 - Rechazar una oferta y aceptar otra para la misma publicacion P2P
    Dado hay una oferta p2p por 2000000 para la publicación del usuario con email "usuario2@test.com"
    Y rechazo la oferta del usuario con email "usuario@test.com"
    Cuando acepto la oferta del usuario con email "usuario2@test.com"
    Entonces se me comunica el correo del comprador que es "usuario2@test.com"
    Y la oferta del usuario con email "usuario@test.com" no fue aceptada
    Y la publicacion esta en estado "Vendido"

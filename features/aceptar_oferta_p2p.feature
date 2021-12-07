#language: es

Característica: Aceptar ofertas p2p
Antecedentes: 
  Dado que mi id_telegram es "12345678"
  Dado que estoy registrado como usuario
  Y que tengo una publicación p2p por un auto patente "AAA000", marca "VW", modelo "Suran", año 2016 y precio 550000
  Y hay una oferta p2p por 2000000 para la publicación del usuario con email "usuario@test.com"

Escenario: AO001 - Aceptar una oferta P2P
  Cuando acepto la oferta
  Entonces se me comunica el correo del comprador
  Y la publicacion esta en estado “Vendido”

@wip
Escenario: AO002 - No se permite aceptar dos ofertas para la misma publicacion P2P
  Dado que hay otra oferta p2p
  Y que acepto la primer oferta p2p
  Cuando acepto la otra oferta p2p
  Entonces se levanta un error de que la publicación ya fue vendida
  Y la oferta 2 no fue aceptada

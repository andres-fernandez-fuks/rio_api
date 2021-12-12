#language: es

Característica: Como vendedor quiero recibir una notificación por email cuando hagan una oferta por una de mis publicaciones

@local
Escenario: NO01 Recibir notificación por ofertas en publicaciones propias
  Dado que estoy registrado con el email 'test@gmail.com'
  Y tengo una publicación creada
  Cuando se crea una oferta para la publicación
  Entonces recibo un correo electrónico con los datos de la oferta a la dirección 'test@gmail.com'
  Y se puede ver el id de la publicación
  Y se puede ver el id de la oferta
  Y se puede ver el nombre del usuario ofertante
  Y se puede ver el monto de la oferta

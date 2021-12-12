
#language: es
Característica: Mail de cotización
  @local
  Escenario: IC01 - Recibir correo cuando se realiza la cotización de una publicación propia
  Dado que estoy registrado con el email 'test@gmail.com'
  Y tengo una publicación en revisión
  Cuando se realiza la cotización
  Entonces recibo un correo electrónico con el informe de la cotización a la dirección 'test@gmail.com'
  Y se puede ver la gravedad de las fallas estéticas
  Y se puede ver la gravedad de las fallas de motor
  Y se puede ver la gravedad de las fallas de neumáticos

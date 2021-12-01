#language: es

Característica: Registro de un usuario
  Antecedentes:
  Dado que hay un auto ingresado para cotizar por el usuario con id "4"

  Escenario: C001 - Cotizacion exitosa de un auto
  Dado que recibo un informe de cotizacion para el auto publicado
  Entonces la cotización del auto publicado es 700000
  Y se activa la publicación con el precio de la cotización para el auto, visible sólo para el usuario con id 4

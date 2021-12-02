#language: es

Característica: Registro de un usuario
  Antecedentes:
    Dado que hay un auto ingresado para cotizar por el usuario con id "4"

  Escenario: C001 - Cotizacion exitosa de un auto
    Cuando recibo un informe de cotizacion para el auto publicado con un precio de 700000
    Entonces la cotización del auto publicado es 700000
    Y obtiene la oferta para el auto, visible sólo para el usuario con id 4

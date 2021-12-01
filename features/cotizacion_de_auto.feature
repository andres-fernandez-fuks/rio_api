#language: es
@wip
Característica: Registro de un usuario
  Antecedentes:
  Dado que hay un auto ingresado para cotizar por el usuario con id "4"

  Escenario: C001 - Cotizacion exitosa de un auto
  Dado que recibo un informe de cotizacion para el auto de la publicacion con id unico 0
  Cuando cotizo el auto
  Entonces la cotización del auto de la publicacion con id unico 0 es 700000
  Y se crea una intención de venta con id único 0 por el valor de la cotización para el auto, visible sólo para el usuario con id 4

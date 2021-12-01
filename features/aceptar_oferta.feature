#language: es

Característica: Aceptar oferta de cotizacion
  @wip
  Escenario: RC01 - Aceptar una cotización marca el auto como vendido
    Dado que hay un auto ingresado para cotizar por el usuario con id "4"
    Y que recibo un informe de cotizacion para el auto publicado
    Cuando acepto la oferta 1
    Entonces la oferta 1 está con estado "Aceptada"


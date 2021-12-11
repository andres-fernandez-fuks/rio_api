#language: es

Característica: Cotización de un auto
  Antecedentes:
    Dado que hay un auto ingresado para cotizar por el usuario con id "4"

  @wip
  Escenario: C001 - Cotizacion exitosa de un auto
    Cuando recibo un informe de cotizacion para el auto publicado con un precio de 700000
    Entonces la cotización del auto publicado es 700000
    Y obtiene la oferta para el auto, visible sólo para el usuario con id 4

  Escenario: COT01
    Dado que se ingresó un auto del año 1994
    Cuando se recibe un informe con falla de tipo 'estetica' con gravedad 'Grave'
    Entonces se cancela la publicación.
  
  Escenario: COT02 - Auto previo a 1995 sin fallas
    Dado que se ingresó un auto del año 1994
    Cuando se recibe un informe sin fallas
    Entonces se realiza una oferta de fiubak por 800000

  Escenario: COT03 - Auto de 1995 sin fallas
    Dado que se ingresó un auto del año 1995
    Cuando se recibe un informe sin fallas
    Entonces se realiza una oferta de fiubak por 1000000

  Escenario: COT04
    Dado que se ingresó un auto del año 2009
    Cuando se recibe un informe sin fallas
    Entonces se realiza una oferta de fiubak por 1000000

  Escenario: COT05
    Dado que se ingresó un auto del año 2010
    Cuando se recibe un informe sin fallas
    Entonces se realiza una oferta de fiubak por 2000000

  Escenario: COT06
    Dado que se ingresó un auto del año 2021
    Cuando se recibe un informe sin fallas
    Entonces se realiza una oferta de fiubak por 2000000

  @wip
  Escenario: COT07
    Dado que se ingresó un auto del año 1995
    Cuando se recibe un informe con falla de tipo Estética con gravedad Leve
    Entonces se realiza una oferta de fiubak por 970000

  @wip
  Escenario: COT08
    Dado que se ingresó un auto del año 1994
    Cuando se recibe un informe con falla de tipo Estética con gravedad Leve
    Entonces se realiza una oferta de fiubak por 776000

  @wip
  Escenario: COT09
    Dado que se ingresó un auto del año 2020
    Cuando se recibe un informe con falla de tipo Estética con gravedad Leve
    Y falla de tipo Neumáticos con gravedad Leve
    Entonces se realiza una oferta de fiubak por 1.880.000

  @wip
  Escenario: COT10
    Dado que se ingresó un auto del año 2005
    Cuando se recibe un informe con falla de tipo Neumáticos con gravedad Leve
    Y falla de tipo Estética con gravedad Grave
    Entonces se realiza una oferta de fiubak por 890000

  @wip
  Escenario: COT11
    Dado que se ingresó un auto del año 2005
    Cuando se recibe un informe con falla de tipo Estética con gravedad Grave
    Entonces se realiza una oferta de fiubak por 920000

  @wip
  Escenario: COT12
    Dado que se ingresó un auto del año 2005
    Cuando se recibe un informe con falla de tipo Motor con gravedad Leve
    Y una falla de tipo Estetica con gravedad Leve
    Y una falla de tipo Neumáticos con gravedad Leve
    Entonces se realiza una oferta de fiubak por 910000

  @wip
  Escenario: COT13
    Dado que se ingresó un auto del año 2005
    Cuando se recibe un informe con falla de tipo Motor con gravedad Grave
    Entonces se realiza una oferta de fiubak por 900000

  @wip
  Escenario: COT14
    Dado que se ingresó un auto del año 2020
    Cuando se recibe un informe con falla de tipo Motor con gravedad Grave
    Y una falla de tipo Estética con gravedad Grave
    Y una falla de tipo Neumáticos con gravedad Leve
    Entonces se realiza una oferta de fiubak por 1.580.000

  @wip
  Escenario: COT15
    Dado que se recibe un auto del año 2010
    Cuando se recibe un informe con falla de tipo Motor con gravedad Grave
    Y una falla de tipo Neumáticos con gravedad Grave
    Entonces se realiza una oferta de fiubak por 820000

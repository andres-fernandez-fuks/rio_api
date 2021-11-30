#language: es
@wip
  Característica: registro de auto para venta
    Antecedentes:
      Dado que estoy registrado como usuario
      Y no hay autos publicados

    Escenario: RV001 - Registro exitoso de un auto con patente vieja
      Cuando registro una intención de venta para el auto "AAA123","Fiat","Cronos",2011,800000
      Entonces la intención de venta se genera correctamente

    Escenario: RV002 - Registro exitoso de un auto con patente nueva
      Cuando registro una intención de venta para el auto "AA123AA","Fiat","Cronos",2011,800000
      Entonces la intención de venta se genera correctamente

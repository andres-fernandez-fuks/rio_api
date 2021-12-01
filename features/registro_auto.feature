#language: es
Característica: registro de auto para venta
  Antecedentes:
    Dado que no hay autos publicados
    Y que mi id_telegram es "123"
    Y que estoy registrado como usuario

  Escenario: RV001 - Registro exitoso de un auto con patente vieja
    Cuando registro una intención de venta para el auto "AAA123","Fiat","Cronos",2011,800000
    Entonces la intención de venta se genera correctamente

  Escenario: RV002 - Registro exitoso de un auto con patente nueva
    Cuando registro una intención de venta para el auto "AA123AA","Fiat","Cronos",2011,800000
    Entonces la intención de venta se genera correctamente

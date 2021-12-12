#language: es

Característica: Validaciones en el registro de usuario
  Antecedentes:
    Dado que mi id_telegram es "12345"
    Y que estoy registrado como usuario
  
  Escenario: VP01 Es posible publicar un auto si hay una publicación Cancelada del mismo
    Dado que existe una publicación "Cancelada" para el auto con patente "AAA333"
    Cuando creo una publicación para el auto con patente "AAA333"
    Entonces la publicación se crea correctamente

  Escenario: VP02 Es posible publicar un auto si hay una publicación Reservada del mismo
    Dado que existe una publicación "Reservada" para el auto con patente "AAA333"
    Cuando creo una publicación para el auto con patente "AAA333"
    Entonces la publicación se crea correctamente

  Escenario: VP03 Es posible publicar un auto si hay una publicación Vendida del mismo
    Dado que existe una publicación "Vendida" para el auto con patente "AAA333"
    Cuando creo una publicación para el auto con patente "AAA333"
    Entonces la publicación se crea correctamente

  Escenario: VP04 No es posible crear una publicación si hay otra “En revisión" para un auto de la misma patente
    Dado que existe una publicación “En revisión" para el auto con patente "AAA333"
    Cuando creo una publicación para el auto con patente "AAA333"
    Entonces recibo un error y la publicación no se creó

  Escenario: VP05 No es posible crear una publicación si hay otra “Cotizada" para un auto de la misma patente
    Dado que existe una publicación "Cotizada" para el auto con patente "AAA333"
    Cuando creo una publicación para el auto con patente "AAA333"
    Entonces recibo un error y la publicación no se creó

  Escenario: VP04 No es posible crear una publicación si hay otra “Activa" para un auto de la misma patente
    Dado que existe una publicación "Activa" para el auto con patente "AAA333"
    Cuando creo una publicación para el auto con patente "AAA333"
    Entonces recibo un error y la publicación no se creó

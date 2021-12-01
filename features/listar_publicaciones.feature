#language:es
@wip
Característica: listar publicaciones
  Antecedentes:
    Dado que estoy registrado como usuario

  Escenario: LP001 - Listado de 0 autos
    Dado hay 0 autos publicados
    Cuando consulto por todas las publicaciones
    Entonces recibo 0 publicaciones

  Escenario: LP002 - Listado de 2 autos
    Dado hay 2 autos publicados
    Cuando consulto por todas las publicaciones
    Entonces recibo 0 publicaciones

  Escenario: LP003 - Listado de 1 publicacion tiene los datos correpondientes
    Dado hay 1 autos publicados
    Cuando consulto por todas las publicaciones
    Entonces recibo 1 publicaciones
    Y tiene los datos correspondientes

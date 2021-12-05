#language: es

Característica: Registro de un usuario
  Antecedentes:
    Dado que mi id_telegram es "123"
    Y que estoy registrado como usuario

  Escenario: MP001 - Listado de mis publicaciones cuando no tengo ninguna
    Dado que no tengo publicaciones
    Cuando consulto por mis publicaciones
    Entonces recibo 0 publicaciones

  Escenario: MP002 - Listado de mis publicaciones cuando tengo un auto publicado
    Dado que tengo un auto publicado patente "AAA000", marca "VW", modelo "Suran", año 2016 y precio 550000
    Y mi publicación todavía está en revisión
    Cuando consulto por mis publicaciones
    Entonces recibo 1 publicaciones
    Y los datos de mi publicación son los correctos

  Escenario: MP003 - Listado de mis publicaciones cuando tengo un auto publicado y cotizado
    Dado que tengo un auto publicado patente "AAA000", marca "VW", modelo "Suran", año 2016 y precio 550000
    Y mi publicación ya fue cotizada
    Cuando consulto por mis publicaciones
    Entonces recibo 1 publicaciones
    Y los datos de mi publicación son los correctos

  Escenario: MP003 - Listar mis publicaciones no muestra publicaciones de otros usuarios
    Dado que hay un auto publicado patente "AAA000", marca "VW", modelo "Suran", año 2016 y precio 550000 por el usuario con id_telegram "otro"
    Cuando consulto por mis publicaciones
    Entonces recibo 0 publicaciones

#language: es

Característica:
  Como fiubak
  Quiero publicar los autos adquiridos
  Para obtener un beneficio económico

  Escenario: FPA001 - Publicar un auto con incremento de precio
    Dado que tengo una oferta a un vendedor por 700000
    Cuando el vendedor la acepta
    Entonces publico el auto con un incremento del 30% a un precio de 910000
@wip
  Escenario: PF001 - Una publicación de FIUBAK se crea con un incremento de precio por sobre la publicación original
    Dado que existe una oferta con precio 10.000 de FIUBAK por una publicación
    Cuando el usuario vendedor acepta la oferta de FIUBAK
    Entonces se crea una nueva publicación de FIUBAK por el mismo auto que la anterior con un precio de 13.000

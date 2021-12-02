#language: es
@wip
Característica:
  Como fiubak
  Quiero publicar los autos adquiridos
  Para obtener un beneficio económico

  Escenario: FPA001 - Publicar un auto con incremento de precio
    Dado que tengo una oferta a un vendedor por 700000
    Cuando el vendedor la acepta
    Entonces publico el auto con un incremento del 30% a un precio de 910000

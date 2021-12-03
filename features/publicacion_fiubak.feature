#language: es

Característica:
  Como fiubak
  Quiero publicar los autos adquiridos
  Para obtener un beneficio económico

  Escenario: PF001 - Una publicación de FIUBAK se crea con un incremento de precio por sobre la publicación original
    Dado que hay un auto ingresado para cotizar por el usuario con id "4"
    Y que existe una oferta con precio 10000 de FIUBAK para la publicacion
    Cuando el usuario vendedor acepta la oferta de FIUBAK
    Entonces se crea una nueva publicación de FIUBAK por el mismo auto que la anterior con un precio de 13000

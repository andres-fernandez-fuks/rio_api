#language: es

Característica: Publicación p2p
  Como usuario vendedor
  Quiero crear una publicación P2P
  Para poder vender mi auto

Escenario: CPP001 - Rechazo de oferta de FIUBAK
    Dado que existe una publicación cotizada
    Cuando se rechaza la oferta de FIUBAK para la publicación
    Entonces la publicación pasa a estado activo
    Y la publicación es de tipo P2P

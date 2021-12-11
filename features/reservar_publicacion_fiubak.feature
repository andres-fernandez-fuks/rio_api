#language:es
Característica:
  Como comprador
  quiero reservar una publicación de FIUBAK
  para obtener un auto
@wip
Escenario: RF01 Reservar publicación FIUBAK
  Dado que mi id_telegram es "1000"
  Y que estoy registrado como usuario
  Y hay	una publicación activa de tipo fiubak
  Cuando reservo la publicación
  Entonces  la publicacion esta en estado "Reservado"
  Y no aparece al listar publicaciones

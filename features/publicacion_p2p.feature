#language: es

@wip
Característica:
  Como fiubak
  Quiero publicar los autos adquiridos
  Para obtener un beneficio económico


  Escenario: CPP001B - Rechazo de oferta de FIUBAK
          Dado que realicé el registró de un vehículo
          Y recibí una oferta de FIUBAK
          Cuando ejecuto el comando /rechazarOferta <id_oferta>
          Entonces se muestra el mensaje “La oferta fue rechazada”.

  Escenario: CPP002B -  Publicación activada
          Dado que realicé el registró de un vehículo
          Y recibí una oferta de FIUBAK
          Y la rechacé
          Cuando ingreso el comando /misPublicaciones
          Entonces veo la publicación en estado “Activa”

  Escenario: CPP001 - Rechazo de oferta de FIUBAK
          Dado que existe una publicación cotizada
          Cuando se rechaza la oferta de FIUBAK para la publicación
          Entonces la publicación pasa a estado activo
          Y la publicación es de tipo P2P

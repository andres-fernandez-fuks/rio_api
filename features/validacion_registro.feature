#language: es
Característica: Validaciones en el registro de usuario
  Antecedentes:
    Dado que no hay ningun usuario registrado

  Escenario: VRO1 - Usuario se intenta registrar con mail ya registrado
    Dado que hay un usuario registrado con el mail "test123@gmail.com"
    Cuando otro usuario se registra con el mail "test123@gmail.com"
    Entonces se retorna un error con el mensaje "El registro no fue posible - Mail en uso"


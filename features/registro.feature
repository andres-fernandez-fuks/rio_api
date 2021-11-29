#language: es
Característica: Registro de un usuario
  Antecedentes:
    Dado que no hay ningun usuario registrado

  Escenario: R001 - Registro exitoso con mail y nombre
    Cuando registro un usuario con nombre 'Fulanito', mail 'fulanito@gmail.com' y id_telegram '14'
    Entonces el usuario se registra correctamente

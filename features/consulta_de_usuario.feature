#language: es
Característica: Registro de un usuario
  Antecedentes:
    Dado que mi id_telegram es "123"

  Escenario: H001 - Comando /help para usuario no registrado
  Dado que no estoy registrado como usuario
  Cuando consulto si soy un usuario registrado
  Entonces recibo un error de usuario no registrado

  Escenario: H002 - Comando /help para usuario registrado
  Dado que estoy registrado como usuario
  Cuando consulto si soy un usuario registrado
  Entonces recibo mi información de usuario

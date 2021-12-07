class UsuarioFiubak < Usuario
  NOMBRE_FIUBAK = 'fiubak'.freeze
  MAIL_FIUBAK = 'fiubak@fiubak.com'.freeze
  ID_TELEGRAM_FIUBAK = 'id-fiubak'.freeze

  def initialize
    super(NOMBRE_FIUBAK, MAIL_FIUBAK, ID_TELEGRAM_FIUBAK)
  end
end

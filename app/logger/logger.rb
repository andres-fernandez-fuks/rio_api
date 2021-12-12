class Logger
  def self.log(nivel, mensaje)
    logger.info "API_FIUBAK - #{mensaje}" if nivel == 'info'
    logger.debug "API_FIUBAK - #{mensaje}" if nivel == 'debug'
    logger.fatal "API_FIUBAK - #{mensaje}" if nivel == 'fatal'
  end
end

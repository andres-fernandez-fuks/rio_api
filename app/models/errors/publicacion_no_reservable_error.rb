class PublicacionNoReservableError < StandardError
  def initialize
    super('La publicacion con no se puede reservar')
  end
end

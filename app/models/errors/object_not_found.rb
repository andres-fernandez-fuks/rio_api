class ObjectNotFound < StandardError
  def initialize(model, id) # rubocop:disable Lint/MissingSuper
    @model = model
    @id = id
  end
end

# rubocop:disable all
require 'spec_helper'
require_relative './factories/user_factory'

RSpec.configure do |config|
  config.include UserFactory
  config.after :each do
    Persistence::Repositories::TagRepository.new.delete_all
    Persistence::Repositories::UserRepository.new.delete_all
    Persistence::Repositories::RepositorioOfertas.new.delete_all
    Persistence::Repositories::RepositorioPublicaciones.new.delete_all
    Persistence::Repositories::RepositorioUsuarios.new.delete_all
  end
end

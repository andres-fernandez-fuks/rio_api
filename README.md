# Web Template

This is a simple web project based on Padrino.

### Run local with Docker Compose

First, get [docker-compose](https://docs.docker.com/compose/install/).

Then, you can run script `start_dev_containers.sh`. After this, you will be inside the container.

## Padrino application setup

1. Run **_bundle install --without staging production_**, to install all application dependencies
1. Run **_RACK_ENV=test bundle exec rake_**, to run all tests and ensure everything is properly setup
1. Run **_RACK_ENV=development bundle exec rake db:migrate db:seed_**, to setup the development database
1. Run **_./start_app.sh_**, to start the application and check health in another terminal at `http://localhost:3000/`

### Deploy with Dockerfile + Heroku

1\) Set `HEROKU_TOKEN` environment var with your heroku token.

2\) Run `./scripts/build-image.sh` to create the binary and then `./scripts/deploy.sh` to update heroku runtime.


# Acceptance Test

During development, when a developer works on his cucumber create an in-process instance of the application, so it is enough to run cucumber, nothing else is needed.

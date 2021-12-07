#!/bin/sh

docker-compose run --rm webapp bundle exec rake db:migrate db:seed
docker-compose up -d
docker-compose exec webapp /bin/bash

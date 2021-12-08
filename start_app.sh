#!/bin/sh
RACK_ENV=development bundle exec rake db:migrate db:seed
RACK_ENV=development bundle exec padrino start -p $PORT -h 0.0.0.0

#!/bin/bash
# IMPORTANT: before running this script ensure to run heroku login!!!!

set -e

# heroku login

APP_NAME=rio-api-test

heroku apps:create $APP_NAME
heroku addons:create heroku-postgresql:hobby-dev --app $APP_NAME
heroku config:set RACK_ENV=staging --app $APP_NAME
heroku drains:add $SUMOLOGIC_SOURCE_TEST --app $APP_NAME

#!/bin/bash
# IMPORTANT: before running this script ensure to run heroku login!!!!

set -e

# heroku login

APP_NAME=rio-api-prod

heroku apps:create $APP_NAME
heroku addons:create heroku-postgresql:hobby-dev --app $APP_NAME
heroku config:set RACK_ENV=production --app $APP_NAME
heroku config:set SMTP_ADDRESS=smtp.sendgrid.net --app $APP_NAME
heroku config:set SMTP_USER=apikey --app $APP_NAME
heroku config:set SMTP_PASS=$SMTP_PASSWORD --app $APP_NAME
heroku config:set SMTP_PORT=587 --app $APP_NAME
heroku drains:add $SUMOLOGIC_SOURCE_PROD --app $APP_NAME

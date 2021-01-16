#!/bin/sh

set -x 

echo "image id: $IMAGE_ID"

DATA='{ "updates": [ { "type": "web", "docker_image":"'
DATA="$DATA$IMAGE_ID"
DATA=$DATA'" } ] }'

echo "data: $DATA"

curl -X PATCH https://api.heroku.com/apps/$HEROKU_APP/formation --header "Content-Type: application/json" --header "Accept: application/vnd.heroku+json; version=3.docker-releases" --header "Authorization: Bearer ${HEROKU_TOKEN}" --data "$DATA" --fail
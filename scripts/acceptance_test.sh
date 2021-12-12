#/bin/bash

export BASE_URL=$1

echo "Running acceptance test on $BASE_URL"
mkdir -p reports
curl --location --request POST "$BASE_URL/deshabilitar_mails"
bundle exec rake acceptance
curl --location --request POST "$BASE_URL/habilitar_mails"

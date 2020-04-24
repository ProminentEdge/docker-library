#!/bin/bash

#source .env

sed -i "s^admin_token^${ADMIN_TOKEN}^" ror.yml
sed -i "s^auth_token^${AUTH_TOKEN}^" ror.yml
sed -i "s^ingest_token^${INGEST_TOKEN}^" ror.yml
sed -i "s^signature_token^${SIGNATURE_TOKEN}^" jwt.yml

make build


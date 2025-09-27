#!/usr/bin/env bash

set -eu
set +x

scriptDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

echo "Starting docker..."
docker-compose up -d

echo "Resetting terminal..."
command -v reset >/dev/null 2>&1 && reset

echo "Running migrations..."
(cd ${scriptDir}/db && yarn install --frozen-lockfile && yarn migrate)

echo "Running seeds..."
(cd ${scriptDir}/db && yarn seed)

echo "Infrastructure ready!"

#!/usr/bin/env bash

if [ -z "${SERVER_NAME}" ]; then
  SERVER_NAME="localhost"
fi

export FACTER_SERVER_NAME="${SERVER_NAME}"

if [ -z "${USERNAME}" ]; then
  USERNAME="root"
fi

export FACTER_USERNAME="${USERNAME}"

if [ -z "${PASSWORD}" ]; then
  PASSWORD="root"
fi

export FACTER_PASSWORD="${PASSWORD}"

puppet apply --modulepath=/src/run/modules /src/run/run.pp

/usr/bin/supervisord

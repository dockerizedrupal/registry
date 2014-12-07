#!/usr/bin/env bash

if [ -z "${PASSWORD}" ]; then
  PASSWORD="root"
fi

export FACTER_PASSWORD="${PASSWORD}"

puppet apply --modulepath=/src/run/modules /src/run/run.pp

/usr/bin/supervisord

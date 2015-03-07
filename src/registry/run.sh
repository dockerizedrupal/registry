#!/usr/bin/env bash

puppet apply --modulepath=/src/registry/run/modules /src/registry/run/run.pp

/usr/bin/supervisord

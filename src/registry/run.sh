#!/usr/bin/env bash

puppet apply --modulepath=/src/registry/run/modules /src/registry/run/run.pp

supervisord -c /etc/supervisor/supervisord.conf

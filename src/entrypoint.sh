#!/usr/bin/env bash

case "${1}" in
  build)
    /bin/su - root -mc "apt-get update && /src/registry/build.sh && /src/registry/clean.sh"
    ;;
  run)
    /bin/su - root -mc "source /src/registry/variables.sh && /src/registry/run.sh"
    ;;
esac

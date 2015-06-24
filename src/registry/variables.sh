#!/usr/bin/env bash

if [ -z "${SERVER_NAME}" ]; then
  SERVER_NAME="localhost"
fi

export FACTER_SERVER_NAME="${SERVER_NAME}"

if [ -z "${TIMEOUT}" ]; then
  TIMEOUT="900"
fi

export FACTER_TIMEOUT="${TIMEOUT}"

if [ -z "${USERNAME}" ]; then
  USERNAME="root"
fi

export FACTER_USERNAME="${USERNAME}"

if [ -z "${PASSWORD}" ]; then
  PASSWORD="root"
fi

export FACTER_PASSWORD="${PASSWORD}"

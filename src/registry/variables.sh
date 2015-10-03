#!/usr/bin/env bash

if [ -z "${SERVER_NAME}" ]; then
  SERVER_NAME="localhost"
fi

export FACTER_SERVER_NAME="${SERVER_NAME}"

if [ -z "${TIMEZONE}" ]; then
  TIMEZONE="Etc/UTC"
fi

export FACTER_TIMEZONE="${TIMEZONE}"

if [ -z "${PROXY_READ_TIMEOUT}" ]; then
  PROXY_READ_TIMEOUT="900"
fi

export FACTER_PROXY_READ_TIMEOUT="${PROXY_READ_TIMEOUT}"

if [ -z "${HTTP_BASIC_AUTH}" ]; then
  HTTP_BASIC_AUTH="Off"
fi

export FACTER_HTTP_BASIC_AUTH="${HTTP_BASIC_AUTH}"

for VARIABLE in $(env); do
  if [[ "${VARIABLE}" =~ ^HTTP_BASIC_AUTH_[[:digit:]]_USERNAME=.*$ ]]; then
    i="$(echo ${VARIABLE} | awk -F '_' '{ print $4 }')"

    HTTP_BASIC_AUTH_USERNAME="HTTP_BASIC_AUTH_${i}_USERNAME"
    HTTP_BASIC_AUTH_PASSWORD="HTTP_BASIC_AUTH_${i}_PASSWORD"

    if [ -z "${!HTTP_BASIC_AUTH_USERNAME}" ]; then
      declare "${HTTP_BASIC_AUTH_USERNAME}=container"
    fi

    if [ -z "${!HTTP_BASIC_AUTH_PASSWORD}" ]; then
      continue
    fi

    export "FACTER_${HTTP_BASIC_AUTH_USERNAME}=${!HTTP_BASIC_AUTH_USERNAME}"
    export "FACTER_${HTTP_BASIC_AUTH_PASSWORD}=${!HTTP_BASIC_AUTH_PASSWORD}"
  fi
done

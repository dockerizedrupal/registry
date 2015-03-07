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

if [ -z "${STORAGE}" ]; then
  STORAGE="local"
fi

export FACTER_STORAGE"${STORAGE}"

export FACTER_S3_REGION="${S3_REGION}"
export FACTER_S3_BUCKET="${S3_BUCKET}"
export FACTER_S3_AWS_ACCESS_KEY_ID="${S3_AWS_ACCESS_KEY_ID}"
export FACTER_S3_AWS_SECRET_ACCESS_KEY="${S3_AWS_SECRET_ACCESS_KEY}"

#!/usr/bin/env bats

FIG_FILE="${BATS_TEST_DIRNAME}/registry.yml"

container() {
  echo "$(fig -f ${FIG_FILE} ps registry | grep registry | awk '{ print $1 }')"
}

setup() {
  fig -f "${FIG_FILE}" up -d --allow-insecure-ssl

  sleep 10

  wget --no-check-certificate https://localhost/ca -O /usr/local/share/ca-certificates/localhost.crt
  update-ca-certificates --fresh
  service docker restart
}

teardown() {
  fig -f "${FIG_FILE}" kill
  fig -f "${FIG_FILE}" rm --force

  rm /usr/local/share/ca-certificates/localhost.crt
  update-ca-certificates --fresh
  service docker restart
}

@test "registry" {
  run docker login --username="root" --password="root" --email="root@localhost" https://localhost/v1/

  [ "${status}" -eq 0 ]
}

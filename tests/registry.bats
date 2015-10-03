#!/usr/bin/env bats

DOCKER_COMPOSE_FILE="${BATS_TEST_DIRNAME}/registry.yml"

container() {
  echo "$(docker-compose -f ${DOCKER_COMPOSE_FILE} ps registry | grep registry | awk '{ print $1 }')"
}

setup() {
  docker-compose -f "${DOCKER_COMPOSE_FILE}" up

  sleep 20

  wget --no-check-certificate https://localhost/ca -O /usr/local/share/ca-certificates/localhost.crt

  update-ca-certificates --fresh

  service docker restart
}

teardown() {
  docker-compose -f "${DOCKER_COMPOSE_FILE}" kill
  docker-compose -f "${DOCKER_COMPOSE_FILE}" rm --force

  rm /usr/local/share/ca-certificates/localhost.crt

  update-ca-certificates --fresh

  service docker restart
}

@test "registry" {
  run docker login --username="container" --password="container" --email="container@localhost" https://localhost

  [ "${status}" -eq 0 ]
}

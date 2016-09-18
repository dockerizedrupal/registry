# Registry

A Docker image for [Distribution](https://github.com/docker/distribution) with [Nginx](http://nginx.org/) in front of it as a reverse proxy for HTTP Basic Authentication.

## Run the container

    CONTAINER="registry-data" && sudo docker run \
      --name "${CONTAINER}" \
      -h "${CONTAINER}" \
      -v /registry/data \
      -v /registry/ssl \
      --entrypoint /bin/echo \
      dockerizedrupal/registry:2.0.0 "Data-only container for Registry."

    CONTAINER="registry" && sudo docker run \
      --name "${CONTAINER}" \
      -h "${CONTAINER}" \
      --restart always \
      -p 80:80 \
      -p 443:443 \
      --volumes-from registry-data \
      -e SERVER_NAME="localhost" \
      -e TIMEZONE="Etc/UTC" \
      -e PROXY_READ_TIMEOUT="900" \
      -e HTTP_BASIC_AUTH="Off" \
      -e HTTP_BASIC_AUTH_1_USERNAME="container" \
      -e HTTP_BASIC_AUTH_1_PASSWORD="" \
      -d \
      dockerizedrupal/registry:2.0.0

## Build the image

    TMP="$(mktemp -d)" \
      && git clone https://github.com/dockerizedrupal/registry.git "${TMP}" \
      && cd "${TMP}" \
      && git checkout 2.0.0 \
      && sudo docker build -t dockerizedrupal/registry:2.0.0 . \
      && cd -

## Add the certification authority (CA) certificate to your host so the Docker client could communicate with the private registry securely

    sudo wget --no-check-certificate https://localhost/ca -O /usr/local/share/ca-certificates/localhost.crt \
      && sudo update-ca-certificates --fresh \
      && sudo service docker restart

## Back up Registry data

    sudo tools/registrydata backup
    
## Restore Registry data from a backup

    sudo tools/registrydata restore

## License

**MIT**

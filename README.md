# docker-registry

A [Docker](https://docker.com/) container for [Docker Registry](https://github.com/docker/docker-registry) with [Nginx](http://nginx.org/) in front of it as a reverse proxy for Basic authentication.

## Run the container

Using the `docker` command:

    CONTAINER="registrydata" && sudo docker run \
      --name "${CONTAINER}" \
      -h "${CONTAINER}" \
      -v /registry \
      viljaste/data:latest

    CONTAINER="registry" && sudo docker run \
      --name "${CONTAINER}" \
      -h "${CONTAINER}" \
      -p 80:80 \
      -p 443:443 \
      --volumes-from registrydata \
      -e SERVER_NAME="localhost" \
      -e TIMEOUT="900" \
      -e USERNAME="root" \
      -e PASSWORD="root" \
      -d \
      viljaste/registry:latest

Using the `docker-compose` command

    TMP="$(mktemp -d)" \
      && GIT_SSL_NO_VERIFY=true git clone https://git.beyondcloud.io/viljaste/docker-registry.git "${TMP}" \
      && cd "${TMP}" \
      && sudo docker-compose up

## Build the image

    TMP="$(mktemp -d)" \
      && GIT_SSL_NO_VERIFY=true git clone https://git.beyondcloud.io/viljaste/docker-registry.git "${TMP}" \
      && cd "${TMP}" \
      && sudo docker build -t viljaste/registry:latest . \
      && cd -

## Add the certification authority (CA) certificate to your host so the Docker client could communicate with the private registry securely

    sudo wget --no-check-certificate https://localhost/ca -O /usr/local/share/ca-certificates/localhost.crt \
      && sudo update-ca-certificates --fresh \
      && sudo service docker restart

## Creating new or updating existing users passwords

    sudo docker exec -i -t registry htpasswd /registry/.htpasswd username

## Back up Registry data

    sudo tools/registrydata backup
    
## Restore Registry data from a backup

    sudo tools/registrydata restore

## License

**MIT**

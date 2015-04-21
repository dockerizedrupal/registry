# docker-registry

A [Docker](https://docker.com/) container for [Docker Registry](https://github.com/docker/docker-registry) with [Nginx](http://nginx.org/) in front of it as a reverse proxy for Basic authentication.

![example2](/example2.png)

![example1](/example1.png)

## Run the container

Using the `docker` command:

    CONTAINER="registrydata" && sudo docker run \
      --name "${CONTAINER}" \
      -h "${CONTAINER}" \
      -v /registry \
      viljaste/data:dev

    CONTAINER="registry" && sudo docker run \
      --name "${CONTAINER}" \
      -h "${CONTAINER}" \
      -p 80:80 \
      -p 443:443 \
      --volumes-from registrydata \
      -e SERVER_NAME="localhost" \
      -e USERNAME="root" \
      -e PASSWORD="root" \
      -d \
      viljaste/registry:dev

Using the `fig` command

    TMP="$(mktemp -d)" \
      && git clone http://git.simpledrupalcloud.com/simpledrupalcloud/docker-registry.git "${TMP}" \
      && cd "${TMP}" \
      && git checkout dev \
      && sudo fig up

## Build the image

    TMP="$(mktemp -d)" \
      && git clone http://git.simpledrupalcloud.com/simpledrupalcloud/docker-registry.git "${TMP}" \
      && cd "${TMP}" \
      && git checkout dev \
      && sudo docker build -t viljaste/registry:dev . \
      && cd -

## Add the certification authority (CA) certificate to your host so the Docker client could communicate with the private registry securely

    sudo wget --no-check-certificate https://localhost/ca -O /usr/local/share/ca-certificates/localhost.crt \
      && sudo update-ca-certificates --fresh \
      && sudo service docker restart

If you are orchestrating Docker containers using [Fig](http://www.fig.sh/) you need to log in to private registry as follows:

    sudo docker login https://localhost/v1/

You can read about the open issue more from here https://github.com/docker/fig/issues/75.

## Creating new or updating existing users passwords

    sudo docker exec -i -t registry htpasswd /registry/.htpasswd username

## Back up Registry data

    sudo tools/registrydata backup
    
## Restore Registry data from a backup

    sudo tools/registrydata restore

## License

**MIT**

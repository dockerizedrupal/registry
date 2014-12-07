# docker-registry

## Registry (STABLE BRANCH)

### Run the container

Using the `docker` command:

    CONTAINER="registrydata" && sudo docker run \
      --name "${CONTAINER}" \
      -h "${CONTAINER}" \
      -v /registry/data \
      simpledrupalcloud/data:latest

    CONTAINER="registry" && sudo docker run \
      --name "${CONTAINER}" \
      -h "${CONTAINER}" \
      -p 80:80 \
      --volumes-from registrydata \
      -d \
      simpledrupalcloud/registry:latest

Using the `fig` command

    TMP="$(mktemp -d)" \
      && git clone http://git.simpledrupalcloud.com/simpledrupalcloud/docker-registry.git "${TMP}" \
      && cd "${TMP}" \
      && sudo fig up

### Build the image

    TMP="$(mktemp -d)" \
      && git clone http://git.simpledrupalcloud.com/simpledrupalcloud/docker-registry.git "${TMP}" \
      && cd "${TMP}" \
      && sudo docker build -t simpledrupalcloud/registry:latest . \
      && cd -

## Back up Registry data

    sudo docker run \
      --rm \
      --volumes-from registrydata \
      -v $(pwd):/backup \
      busybox:latest tar czvf /backup/registrydata.tar.gz /registry/data

## Restore Registry data from a backup

    sudo docker run \
      --rm \
      --volumes-from registrydata \
      -v $(pwd):/backup \
      busybox:latest tar xzvf /backup/registrydata.tar.gz

## License

**MIT**

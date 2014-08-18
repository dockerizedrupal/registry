docker-docker-registry
======================

Docker image to run a private Docker registry server

Build the Docker image by yourself
----------------------------------

    $ docker build -t docker-registry.simpledrupalcloud.com/docker-registry http://git.simpledrupalcloud.com/simpledrupalcloud/docker-docker-registry.git

Push the Docker image to private Docker registry
------------------------------------------------

    $ docker push docker-registry.simpledrupalcloud.com/docker-registry

Pull the pre-built Docker image from the private Docker registry
----------------------------------------------------------------

    $ docker pull docker-registry.simpledrupalcloud.com/docker-registry

Run the container
-----------------

    $ docker run --name docker-registry -d docker-registry.simpledrupalcloud.com/docker-registry

Stop the container
------------------

    $ docker stop docker-registry
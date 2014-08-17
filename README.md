docker-docker-registry
======================

Docker image to run a Docker registry server

Build the image
---------------

`$ docker build -t docker-registry.simpledrupalcloud.com/docker-registry http://git.simpledrupalcloud.com/simpledrupalcloud/docker-docker-registry.git`

Push the image to private docker registry
-----------------------------------------

`$ docker push docker-registry.simpledrupalcloud.com/docker-registry`

Pull the image from the private docker registry
-----------------------------------------------

`$ docker pull docker-registry.simpledrupalcloud.com/docker-registry`

Run the container
-----------------

`$ docker run --name docker-registry -d docker-registry.simpledrupalcloud.com/docker-registry`
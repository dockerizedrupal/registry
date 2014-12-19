FROM simpledrupalcloud/base:latest

MAINTAINER Simple Drupal Cloud <support@simpledrupalcloud.com>

ENV DEBIAN_FRONTEND noninteractive
ENV SETTINGS_FLAVOR registry

ADD ./src /src

RUN apt-get update

RUN /src/build.sh
RUN /src/clean.sh

VOLUME ["/registry/data"]
VOLUME ["/registry/ssl/certs"]
VOLUME ["/registry/ssl/private"]

EXPOSE 80
EXPOSE 443

CMD ["/src/run.sh"]

FROM simpledrupalcloud/nginx:dev

MAINTAINER Simple Drupal Cloud <support@simpledrupalcloud.com>

ENV DEBIAN_FRONTEND noninteractive

ADD ./src /src

RUN apt-get update

RUN /src/build.sh
RUN /src/clean.sh

VOLUME ["/registry/data"]

EXPOSE 443

CMD ["/src/run.sh"]

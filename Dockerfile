FROM viljaste/base:dev

MAINTAINER Jürgen Viljaste <j.viljaste@gmail.com>

ENV TERM xterm
ENV DEBIAN_FRONTEND noninteractive
ENV SETTINGS_FLAVOR registry

ADD ./src /src

RUN /src/entrypoint.sh build

VOLUME ["/registry"]

EXPOSE 80
EXPOSE 443

CMD ["/src/entrypoint.sh", "run"]

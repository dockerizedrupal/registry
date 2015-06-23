FROM viljaste/base:latest

MAINTAINER Jürgen Viljaste <j.viljaste@gmail.com>

ENV TERM xterm
ENV SETTINGS_FLAVOR registry

ADD ./src /src

RUN /src/entrypoint.sh build

VOLUME ["/registry"]

EXPOSE 80
EXPOSE 443

ENTRYPOINT ["/src/entrypoint.sh", "run"]

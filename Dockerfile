FROM ubuntu:14.04

ADD install.sh install.sh
RUN ./install.sh

USER znc
WORKDIR /home/znc

EXPOSE      6667
ENTRYPOINT  ["/usr/bin/znc", "--foreground"]
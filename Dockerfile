FROM debian_i386:wheezy
MAINTAINER  Robin Schneider <ypid@riseup.net>

RUN DEBIAN_FRONTEND=noninteractive ;\
    apt-get update && \
    apt-get install --assume-yes \
        libreoffice-writer \
        libreoffice-java-common \
        '^libreoffice-.*-(en|de)$' \
        locales

## Make shared library from Duden-Rechtschreibprüfung findable
## libstlport_gcc.so => not found
RUN echo '/usr/lib/ure/lib' > /etc/ld.so.conf.d/duden.conf && \
    ldconfig

RUN (for locale in de_DE en_US; do echo "${locale}.UTF-8 UTF-8"; done) >> /etc/locale.gen && \
    DEBIAN_FRONTEND=noninteractive dpkg-reconfigure locales

RUN useradd --create-home --skel /bin/bash user
RUN chown --recursive user:user /home/user

ENV LANG de_DE.UTF-8

VOLUME [ "/home/user" ]
USER user
WORKDIR /home/user

FROM alpine:3.4
MAINTAINER Jeremy J. Zaner <zahner@joshmartin.ch>

ENV CADDY_VERSION v0.9.3

RUN apk update && apk upgrade && \
    apk add curl && \
    rm -rf /var/cache/apk/*

RUN mkdir -p /tmp/caddy \
 && curl -sL -o /tmp/caddy/caddy_linux_amd64.tar.gz "https://github.com/mholt/caddy/releases/download/$CADDY_VERSION/caddy_linux_amd64.tar.gz" \
 && tar -zxf /tmp/caddy/caddy_linux_amd64.tar.gz -C /tmp/caddy \
 && mv /tmp/caddy/caddy_linux_amd64 /tmp/caddy/caddy \
 && mv /tmp/caddy/caddy /usr/bin/ \
 && chmod +x /usr/bin/caddy \
 && rm -rf /tmp/caddy

ENV DOCKER_GEN_VERSION 0.7.3
ENV CADDY_OPTIONS ""

RUN curl -sL -o docker-gen-linux-amd64-$DOCKER_GEN_VERSION.tar.gz https://github.com/jwilder/docker-gen/releases/download/$DOCKER_GEN_VERSION/docker-gen-linux-amd64-$DOCKER_GEN_VERSION.tar.gz \
 && tar -C /usr/local/bin -xvzf docker-gen-linux-amd64-$DOCKER_GEN_VERSION.tar.gz \
 && rm /docker-gen-linux-amd64-$DOCKER_GEN_VERSION.tar.gz

RUN printf ":80\nproxy / caddyserver.com" > /etc/Caddyfile

ADD etc /etc

ENV DOCKER_HOST unix:///tmp/docker.sock

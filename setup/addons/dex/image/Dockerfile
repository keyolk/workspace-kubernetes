FROM alpine:3.4

MAINTAINER Chanhun Jeong <keyolk@gmail.com>

RUN apk add --update ca-certificates openssl

COPY example-app /usr/local/bin/example-app

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

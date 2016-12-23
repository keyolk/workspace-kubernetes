FROM alpine:3.2
MAINTAINER 	Martin Devlin <martin.devlin@pearson.com>

ENV VAULT_VERSION    0.5.2

COPY config.json /etc/vault/cfg/config.json

RUN apk --update add openssl zip \
&& wget http://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip \
&& unzip vault_${VAULT_VERSION}_linux_amd64.zip \
&& mv vault /usr/local/bin/ \
&& rm -f vault_${VAULT_VERSION}_linux_amd64.zip

ENTRYPOINT ["/usr/local/bin/vault"]
CMD ["server", "-config", "/etc/vault/cfg/config.json"]

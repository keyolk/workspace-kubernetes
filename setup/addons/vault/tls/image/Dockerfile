FROM alpine:3.2
MAINTAINER 	Martin Devlin <martin.devlin@pearson.com>

ENV VAULT_VERSION    0.5.2
ENV VAULT_HTTP_PORT  80
ENV VAULT_HTTPS_PORT 443

COPY config.json /etc/vault/config.json

RUN apk --update add openssl zip\
&& mkdir -p /etc/vault/ssl \
&& wget http://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip \
&& unzip vault_${VAULT_VERSION}_linux_amd64.zip \
&& mv vault /usr/local/bin/ \
&& rm -f vault_${VAULT_VERSION}_linux_amd64.zip

EXPOSE ${VAULT_HTTP_PORT}
EXPOSE ${VAULT_HTTPS_PORT}

COPY /run.sh /usr/bin/run.sh
RUN chmod +x /usr/bin/run.sh

ENTRYPOINT ["/usr/bin/run.sh"]
CMD []

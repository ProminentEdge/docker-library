# Elasticsearch 7.5.2

# This image re-bundles the Docker image from the upstream provider, Elastic.
FROM docker.elastic.co/elasticsearch/elasticsearch:7.5.2
LABEL maintainer=devops@prominentedge.com

ARG admin_token
ARG ingest_token
ARG auth_token
ARG signature_token

ENV ADMIN_TOKEN=$admin_token
ENV INGEST_TOKEN=$ingest_token
ENV AUTH_TOKEN=$admin_token
ENV SIGNATURE_TOKEN=$signature_token

USER root

ENV JQ_VERSION 1.5 
ENV JQ_SHA256 c6b3a7d7d3e7b70c6f51b706a3b90bd01833846c54d32ca32f0027f00226ff6d
RUN cd /tmp \
    && curl -o /usr/bin/jq -SL "https://github.com/stedolan/jq/releases/download/jq-$JQ_VERSION/jq-linux64" \
    && echo "$JQ_SHA256  /usr/bin/jq" | sha256sum -c - \ 
    && chmod +x /usr/bin/jq

# https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html#_c_customized_image
ADD elasticsearch.yml /usr/share/elasticsearch/config/
ADD jwt.yml /usr/share/elasticsearch/config/
ADD ror.yml /usr/share/elasticsearch/config/

RUN chown elasticsearch:elasticsearch config/elasticsearch.yml

COPY plugins /tmp/plugins

RUN sed -i "s/admin_token/${ADMIN_TOKEN}/g" /usr/share/elasticsearch/config/ror.yml && \
    sed -i "s/auth_token/${AUTH_TOKEN}/g" /usr/share/elasticsearch/config/ror.yml && \
    sed -i "s/ingest_token/${INGEST_TOKEN}/g" /usr/share/elasticsearch/config/ror.yml && \
    sed -i "s/signature_token/${SIGNATURE_TOKEN}/g" /usr/share/elasticsearch/config/jwt.yml

RUN chmod 755 -R /tmp/plugins \
    && ls -l /tmp/plugins/readonlyrest-1.19.4_es7.5.2.zip

USER elasticsearch

RUN bin/elasticsearch-plugin install --batch file:///tmp/plugins/readonlyrest-1.19.4_es7.5.2.zip && \
    bin/elasticsearch-plugin install --batch repository-s3


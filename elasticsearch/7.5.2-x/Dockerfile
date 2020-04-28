# Elasticsearch 7.5.2

# This image re-bundles the Docker image from the upstream provider, Elastic.
FROM docker.elastic.co/elasticsearch/elasticsearch:7.5.2
LABEL maintainer=devops@prominentedge.com

USER root

ENV JQ_VERSION 1.5 
ENV JQ_SHA256 c6b3a7d7d3e7b70c6f51b706a3b90bd01833846c54d32ca32f0027f00226ff6d

RUN mkdir -p /usr/share/elasticsearch/ && \
    chmod -R 777 /usr/share/elasticsearch/ && \
    chown -R elasticsearch:elasticsearch /usr/share/elasticsearch/

ENV ES_PATH_CONF=/usr/share/elasticsearch/

RUN cd /tmp \
    && curl -o /usr/bin/jq -SL "https://github.com/stedolan/jq/releases/download/jq-$JQ_VERSION/jq-linux64" \
    && echo "$JQ_SHA256  /usr/bin/jq" | sha256sum -c - \ 
    && chmod +x /usr/bin/jq

COPY plugins /tmp/plugins

RUN chmod 755 -R /tmp/plugins \
    && ls -l /tmp/plugins/readonlyrest-1.19.4_es7.5.2.zip

USER elasticsearch

RUN bin/elasticsearch-plugin install --batch file:///tmp/plugins/readonlyrest-1.19.4_es7.5.2.zip && \
    bin/elasticsearch-plugin install --batch repository-s3


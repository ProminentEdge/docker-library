# Elasticsearch 7.8.1

# This image re-bundles the Docker image from the upstream provider, Elastic.
FROM docker.elastic.co/elasticsearch/elasticsearch:7.8.1
LABEL maintainer=devops@prominentedge.com

USER root

ENV JQ_VERSION 1.5 
ENV JQ_SHA256 c6b3a7d7d3e7b70c6f51b706a3b90bd01833846c54d32ca32f0027f00226ff6d

RUN mkdir -p /etc/elasticsearch/ && \
    chmod -R 777 /etc/elasticsearch/ && \
    chown -R elasticsearch:elasticsearch /etc/elasticsearch/

ENV ES_PATH_CONF=/etc/elasticsearch/

RUN cd /tmp \
    && curl -o /usr/bin/jq -SL "https://github.com/stedolan/jq/releases/download/jq-$JQ_VERSION/jq-linux64" \
    && echo "$JQ_SHA256  /usr/bin/jq" | sha256sum -c - \ 
    && chmod +x /usr/bin/jq

# https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html#_c_customized_image
ADD jwt.yml /etc/elasticsearch/
ADD ror.yml /etc/elasticsearch/
ADD jvm.options /etc/elasticsearch/

#RUN chown elasticsearch:elasticsearch /etc/elasticsearch/elasticsearch/elasticsearch.yml
RUN chown elasticsearch:elasticsearch /etc/elasticsearch/jwt.yml
RUN chown elasticsearch:elasticsearch /etc/elasticsearch/ror.yml

COPY plugins /tmp/plugins

RUN chmod 755 -R /tmp/plugins \
    && ls -l /tmp/plugins/readonlyrest-1.21.0_es7.8.1.zip

USER elasticsearch

RUN bin/elasticsearch-plugin install --batch file:///tmp/plugins/readonlyrest-1.21.0_es7.8.1.zip && \
    bin/elasticsearch-plugin install --batch repository-s3


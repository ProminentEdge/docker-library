# Elasticsearch 6.8.6

# This image re-bundles the Docker image from the upstream provider, Elastic.
FROM docker.elastic.co/elasticsearch/elasticsearch:6.8.6@sha256:81473aab06ae49a5058210610ac848cc8ae3393f319f23d4c5d982580b54ba36
LABEL maintainer=devops@prominentedge.com

# The upstream image was built by:
#   https://github.com/elastic/dockerfiles/tree/v6.8.6/elasticsearch

# For a full list of supported images and tags visit https://www.docker.elastic.co

# For Elasticsearch documentation visit https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html

# See https://github.com/docker-library/official-images/pull/4916 for more details.

USER root

ENV JQ_VERSION 1.5 
ENV JQ_SHA256 c6b3a7d7d3e7b70c6f51b706a3b90bd01833846c54d32ca32f0027f00226ff6d
RUN cd /tmp \
    && curl -o /usr/bin/jq -SL "https://github.com/stedolan/jq/releases/download/jq-$JQ_VERSION/jq-linux64" \
    && echo "$JQ_SHA256  /usr/bin/jq" | sha256sum -c - \ 
    && chmod +x /usr/bin/jq

# https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html#_c_customized_image
ADD elasticsearch.yml /usr/share/elasticsearch/config/
RUN chown elasticsearch:elasticsearch config/elasticsearch.yml

USER elasticsearch

RUN bin/elasticsearch-plugin install --force repository-s3 && \
    bin/elasticsearch-plugin install --force analysis-icu


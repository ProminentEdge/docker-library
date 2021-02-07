ARG ES_VERSION=6.4.1
FROM docker.elastic.co/elasticsearch/elasticsearch:${ES_VERSION}

ARG BUILD_DATE
ARG BUILD_NUMBER
ARG VERSION=6.4.1
ARG JQ_VERSION=1.6
ARG ROR_VERSION=1.16.33

LABEL maintainer="devops@prominentedge.com" \
      description="This is a base image ${ES_VERSION} docker image managed by devops team" \
      vendor="Statengine" \
      version="${VERSION}" \
      build-date="${BUILD_DATE}" \
      build-number="${BUILD_NUMBER}"

ENV ES_VERSION="${VERSION}" \
    BUILD_DATE="${BUILD_DATE}" \
    BUILD_NUMBER="${BUILD_NUMBER}" \
    JQ_VERSION="${JQ_VERSION}" \
    JQ_SHA256="c6b3a7d7d3e7b70c6f51b706a3b90bd01833846c54d32ca32f0027f00226ff6d" \
    ROR_VERSION="${ROR_VERSION}"

COPY --chown=elasticsearch:elasticsearch elasticsearch.yml /usr/share/elasticsearch/config/
COPY plugins/readonlyrest-${ROR_VERSION}_es${ES_VERSION}.zip /tmp/plugins/

RUN \
    # install jq
    curl -sLO "https://raw.githubusercontent.com/stedolan/jq/master/sig/v${JQ_VERSION}/sha256sum.txt" && \
    shasum=$(grep "linux64" sha256sum.txt | awk '{print $1}') && \
    curl \
      -o jq \
      -SL "https://github.com/stedolan/jq/releases/download/jq-${JQ_VERSION}/jq-linux64" && \
    echo "$shasum jq" | sha256sum -c - && \
    chmod +x jq && \
    mv jq /usr/bin/jq && \
    \
    # permissions on plugins
    chmod 755 -R /tmp/plugins

USER elasticsearch

RUN bin/elasticsearch-plugin install --batch file:///tmp/plugins/readonlyrest-${ROR_VERSION}_es${ES_VERSION}.zip && \
    bin/elasticsearch-plugin install --batch repository-s3

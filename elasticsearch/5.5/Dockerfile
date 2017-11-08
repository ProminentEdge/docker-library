FROM docker.elastic.co/elasticsearch/elasticsearch:5.5.2
LABEL maintainer=devops@prominentedge.com

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

COPY plugins /tmp/plugins

RUN chmod 755 -R /tmp/plugins \
    && ls -l /tmp/plugins/readonlyrest-1.16.13_es5.5.2.zip

USER elasticsearch

RUN bin/elasticsearch-plugin install io.fabric8:elasticsearch-cloud-kubernetes:5.5.2 && \
    #bin/elasticsearch-plugin install file:///tmp/plugins/readonlyrest-1.16.13_es5.5.2.zip && \
    bin/elasticsearch-plugin install repository-s3

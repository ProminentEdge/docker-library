# Elasticsearch 7.8.1

# This image re-bundles the Docker image from the upstream provider, Elastic.
FROM docker.elastic.co/elasticsearch/elasticsearch:7.8.1
LABEL maintainer=devops@prominentedge.com

USER elasticsearch

RUN bin/elasticsearch-plugin install --batch file:///tmp/plugins/readonlyrest-1.21.0_es7.8.1.zip && \
    bin/elasticsearch-plugin install --batch repository-s3


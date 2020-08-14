# Makefile for building stat-engine


ORG ?= prominentedgestatengine
REPO ?= elasticsearch
ENVIRONMENT ?= development

SHA=$(shell git rev-parse --short HEAD)
BRANCH=$(shell git rev-parse --symbolic-full-name --abbrev-ref HEAD)

TAG=${BRANCH}-${SHA}-${ENVIRONMENT}-7.5.2

script:
	./build.sh

build:
	docker build \
	-t $(ORG)/$(REPO):${TAG} \
	--no-cache \
	.

	echo "TAG=${TAG}" > tag.properties

push:
	docker push \
	$(ORG)/$(REPO):${TAG}


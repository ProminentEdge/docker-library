# Makefile for building stat-engine


ORG ?= prominentedgestatengine
REPO ?= elasticsearch
PUBLIC_REPO = public-$(REPO)
ENVIRONMENT ?= development

SHA=$(shell git rev-parse --short HEAD)
BRANCH=$(shell git rev-parse --symbolic-full-name --abbrev-ref HEAD)

TAG=${BRANCH}-${SHA}-${ENVIRONMENT}-6.8.6

build:
	docker build \
	-t $(ORG)/$(REPO):${TAG} \
	-t $(ORG)/$(PUBLIC_REPO):${TAG} \
	--no-cache \
	.

	echo "TAG=${TAG}" > tag.properties

push:
	docker push \
	$(ORG)/$(REPO):${TAG}

	docker tag $(ORG)/$(PUBLIC_REPO):${TAG} $(ORG)/$(PUBLIC_REPO):latest

	docker push \
	$(ORG)/$(PUBLIC_REPO):${TAG}

	docker push \
	$(ORG)/$(PUBLIC_REPO):latest

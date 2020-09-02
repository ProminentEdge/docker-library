# Makefile for building stat-engine


REPO ?= elasticsearch
ORG = 445861113736.dkr.ecr.us-east-1.amazonaws.com
TAG = latest

SHA=$(shell git rev-parse --short HEAD)
BRANCH=$(shell git rev-parse --symbolic-full-name --abbrev-ref HEAD)

build:
	docker build \
	-t $(ORG)/$(REPO):${TAG} \
	-t $(ORG)/$(REPO):${TAG} \
	--network=host \
	--no-cache \
	.

	echo "TAG=${TAG}" > tag.properties

push:
	docker push \
	$(ORG)/$(REPO):${TAG}

	docker tag $(ORG)/$(REPO):${TAG} $(ORG)/$(REPO):latest

	docker push \
	$(ORG)/$(REPO):${TAG}

	docker push \
	$(ORG)/$(REPO):latest

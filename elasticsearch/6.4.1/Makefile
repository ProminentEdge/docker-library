# Build Custom ES with ROR plugin Docker Image Makefile
BUILD_DATE ?= $(strip $(shell date -u +"%Y-%m-%dT%H:%M:%SZ"))
BUILD_NUMBER ?= $(BUILD_NUMBER)
ENVIRONMENT ?= $(ENVIRONMENT)
ES_VERSION ?= 6.4.1
JQ_VERSION ?= 1.6
ROR_VERSION ?= 1.16.33
ORG = prominentedgestatengine
REPO ?= elasticsearch
SHA = $(shell git rev-parse --short HEAD)
BRANCH = $(shell git rev-parse --symbolic-full-name --abbrev-ref HEAD)
DOCKER_BRANCH = $(subst /,-,$(BRANCH))
TAG ?= $(ENVIRONMENT)-elasticsearch-$(ES_VERSION)-$(DOCKER_BRANCH)-$(SHA)
DOCKER_IMG ?= $(ORG)/$(REPO):$(TAG)
DOCKERHUB_USER ?=
DOCKERHUB_PASSWORD ?=

all: build push

default: build

login:
	docker login \
		--username $(DOCKERHUB_USER) \
		--password $(DOCKERHUB_PASSWORD)

build:
	docker build \
		--no-cache \
		--force-rm \
		--build-arg BUILD_DATE=$(BUILD_DATE) \
		--build-arg BUILD_NUMBER=$(BUILD_NUMBER) \
		--build-arg JQ_VERSION=$(JQ_VERSION) \
		--build-arg ROR_VERSION=$(ROR_VERSION) \
		--build-arg ES_VERSION=$(ES_VERSION) \
		--build-arg VERSION=$(ES_VERSION) \
		-t $(ORG)/$(REPO):$(ENVIRONMENT)-elasticsearch-$(ES_VERSION)-latest \
		-t $(DOCKER_IMG) .

push:
	docker push $(ORG)/$(REPO):$(ORG)/$(REPO):$(ENVIRONMENT)-elasticsearch-$(ES_VERSION)-latest
	docker push $(DOCKER_IMG)

ls list:
	@$(MAKE) -pRrq -f $(lastword $(MAKEFILE_LIST)) : 2>/dev/null | awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' | sort | egrep -v -e '^[^[:alnum:]]' -e '^$@$$'

.PHONY: login build push ls list

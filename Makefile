DOCKER_IMAGE = 360cloud/website
RELEASE_VERSION :=$(shell git describe --always --tags)

.PHONY: release run build build-image push-image

release: build-image push-image

run:
	hugo server

build: ## Build site with production settings and put deliverables in ./public
	hugo

build-image:
	docker build --no-cache . --tag $(DOCKER_IMAGE):$(RELEASE_VERSION)

push-image:
	docker push $(DOCKER_IMAGE):$(RELEASE_VERSION)

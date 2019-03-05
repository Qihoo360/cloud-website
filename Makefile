DOCKER_IMAGE = 360cloud/website
RELEASE_VERSION :=$(shell git describe --always --tags)

.PHONY: release run-website run-wayne-docs build-image push-image

release: build-image push-image

run-website:
	hugo server

run-wayne-docs:
	cd docs/wayne  && gitbook install && gitbook serve

build-image:
	docker build --no-cache . --tag $(DOCKER_IMAGE):$(RELEASE_VERSION)

push-image:
	docker push $(DOCKER_IMAGE):$(RELEASE_VERSION)

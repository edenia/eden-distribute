include ./mkutils/meta.mk ./mkutils/help.mk

LATEST_TAG ?= latest

install: ##@local Install all dependencies
install:
	@yarn install

clean-install: ##@local Reinstalls all dependencies
clean-install:
	@rm -Rf node_modules
	@yarn install

run: ##@local Run the project locally (without docker)
run: node_modules
	@$(SHELL_EXPORT) yarn run powerup

build-docker: ##@devops Build the docker image
build-docker: ./Dockerfile
	@docker pull $(DOCKER_REGISTRY)/$(IMAGE_NAME_DISTRIBUTE):$(VERSION) || true
	@docker build \
		--target release \
		-t $(DOCKER_REGISTRY)/$(IMAGE_NAME_DISTRIBUTE):$(VERSION) \
		-t $(DOCKER_REGISTRY)/$(IMAGE_NAME_DISTRIBUTE):$(LATEST_TAG) \
		.

pull-image: ##@devops Pull the latest image from registry for caching
pull-image:
	@docker pull $(DOCKER_REGISTRY)/$(IMAGE_NAME_DISTRIBUTE):$(LATEST_TAG) || true

build-docker-cached: ##@devops Build the docker image using cached layers
build-docker-cached: ./Dockerfile
	@docker build \
		--target prod-stage \
		--cache-from $(DOCKER_REGISTRY)/$(IMAGE_NAME_DISTRIBUTE):$(LATEST_TAG) \
		-t $(DOCKER_REGISTRY)/$(IMAGE_NAME_DISTRIBUTE):$(VERSION) \
		-t $(DOCKER_REGISTRY)/$(IMAGE_NAME_DISTRIBUTE):$(LATEST_TAG) \
		.

push-image: ##@devops Push the freshly built image and tag with release or latest tag
push-image:
	@docker push $(DOCKER_REGISTRY)/$(IMAGE_NAME_DISTRIBUTE):$(VERSION)

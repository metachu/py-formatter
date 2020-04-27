APP_NAME=py-formatter
DOCKER_REPO=docker.io/metachu

build:
	docker build -t metachu/py-formatter:latest .

tag-version: build
	@echo 'create tag $(VERSION)'
	docker tag $(DOCKER_REPO)/$(APP_NAME):latest  $(DOCKER_REPO)/$(APP_NAME):$(VERSION)

publish-version: tag-version ## Publish the `{version}` taged container to ECR
	@echo 'publish $(VERSION) to $(DOCKER_REPO)'
	docker push $(DOCKER_REPO)/$(APP_NAME):$(VERSION)

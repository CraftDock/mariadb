## Meta data about the image
DOCKER_IMAGE=dsuite/mariadb
DOCKER_IMAGE_CREATED=$(shell date -u +'%Y-%m-%dT%H:%M:%SZ')
DOCKER_IMAGE_REVISION=$(shell git rev-parse --short HEAD)

## Current directory
DIR:=$(strip $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST)))))

## Define the latest version of mariadb
latest = 10.8

##
.DEFAULT_GOAL := help
.PHONY: *


help: ## Display this help
	@printf "\n\033[33mUsage:\033[0m\n  make \033[32m<target>\033[0m \033[36m[\033[0marg=\"val\"...\033[36m]\033[0m\n\n\033[33mTargets:\033[0m\n"
	@awk 'BEGIN {FS = ":.*##"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[32m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

build-all: ## Build all supported versions
	@$(MAKE) build v=10.9-rc
	@$(MAKE) build v=10.8
	@$(MAKE) build v=10.7
	@$(MAKE) build v=10.6
	@$(MAKE) build v=10.5
	@$(MAKE) build v=10.4
	@$(MAKE) build v=10.3
	@$(MAKE) build v=10.2

build: ## Build a specific version of mariadb (make build v=10.5)
	@$(eval version := $(or $(v),$(latest)))
	@docker run --rm \
		-e MARIADB_VERSION=$(version) \
		-e DOCKER_IMAGE_CREATED=$(DOCKER_IMAGE_CREATED) \
		-e DOCKER_IMAGE_REVISION=$(DOCKER_IMAGE_REVISION) \
		-v $(DIR)/Dockerfiles:/data \
		dsuite/alpine-data \
		sh -c "templater Dockerfile.template > Dockerfile-$(version)"
	@docker build --force-rm \
		--file $(DIR)/Dockerfiles/Dockerfile-$(version) \
		--tag $(DOCKER_IMAGE):$(version) \
		$(DIR)/Dockerfiles
	@[ "$(version)" = "$(latest)" ] && docker tag $(DOCKER_IMAGE):$(version) $(DOCKER_IMAGE):latest || true

push-all: ## Push all supported versions
	@$(MAKE) push v=10.8
	@$(MAKE) push v=10.7
	@$(MAKE) push v=10.6
	@$(MAKE) push v=10.5
	@$(MAKE) push v=10.4
	@$(MAKE) push v=10.3
	@$(MAKE) push v=10.2

push: ## Push a specific version of mariadb ( make build v=10.5)
	@$(eval version := $(or $(v),$(latest)))
	@docker push $(DOCKER_IMAGE):$(version)
	@[ "$(version)" = "$(latest)" ] && docker push $(DOCKER_IMAGE):latest || true


run: ## Get command prompt inside container
	@$(eval version := $(or $(v),$(latest)))
	@mkdir -p $(DIR)/tmp/db_startup $(DIR)/tmp/db_config $(DIR)/tmp/db_data $(DIR)/tmp/db_backup $(DIR)/tmp/db_log
	@docker run -it --rm \
		-e MYSQL_ROOT_PASSWORD=rootpassword \
		-e MYSQL_DATABASE=TestBase \
		-e MYSQL_USER=test \
		-e MYSQL_PASSWORD=test \
		-v $(DIR)/tmp/db_startup:/docker-entrypoint-initdb.d \
		-v $(DIR)/tmp/db_config:/etc/mysql/conf.d \
		-v $(DIR)/tmp/db_data:/var/lib/mysql \
		-v $(DIR)/tmp/db_log:/var/log/mysql \
		-v $(DIR)/tmp/db_backup:/backup \
		--name mariadb-$(version) \
		$(DOCKER_IMAGE):$(version)


remove: ## Remove all generated images
	@docker images | grep $(DOCKER_IMAGE) | tr -s ' ' | cut -d ' ' -f 2 | xargs -I {} docker rmi $(DOCKER_IMAGE):{} || true
	@docker images | grep $(DOCKER_IMAGE) | tr -s ' ' | cut -d ' ' -f 3 | xargs -I {} docker rmi {} || true


readme: ## Generate docker hub full description
	@docker run -t --rm \
		-e DOCKER_USERNAME=${DOCKER_USERNAME} \
		-e DOCKER_PASSWORD=${DOCKER_PASSWORD} \
		-e DOCKER_IMAGE=${DOCKER_IMAGE} \
		-v $(DIR):/data \
		dsuite/hub-updater

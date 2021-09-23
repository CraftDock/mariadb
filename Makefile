## Meta data about the image
DOCKER_IMAGE=dsuite/mariadb
DOCKER_IMAGE_CREATED=$(shell date -u +'%Y-%m-%dT%H:%M:%SZ')
DOCKER_IMAGE_REVISION=$(shell git rev-parse --short HEAD)

## Current directory
DIR:=$(strip $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST)))))

## Define the latest version of mariadb
latest = 10.5

# env file
include $(DIR)/make.env

##
.DEFAULT_GOAL := help
.PHONY: *


help: ## Display this help
	@printf "\n\033[33mUsage:\033[0m\n  make \033[32m<target>\033[0m \033[36m[\033[0marg=\"val\"...\033[36m]\033[0m\n\n\033[33mTargets:\033[0m\n"
	@awk 'BEGIN {FS = ":.*##"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[32m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

build-all: ## Build all supported versions
	@$(MAKE) build v=10.5
	@$(MAKE) build v=10.4
	@$(MAKE) build v=10.3
	@$(MAKE) build v=10.2
	@$(MAKE) build v=10.1

build: ## Build a specific version of mariadb ( make build v=10.5)
	@$(eval version := $(or $(v),$(latest)))
	@docker run --rm \
		-e MARIADB_MAJOR=$(MARIADB_$(version)_MAJOR) \
		-e MARIADB_VERSION=$(MARIADB_$(version)_VERSION) \
		-e MARIADB_ALPINE=$(MARIADB_$(version)_ALPINE) \
		-e DOCKER_IMAGE_CREATED=$(DOCKER_IMAGE_CREATED) \
		-e DOCKER_IMAGE_REVISION=$(DOCKER_IMAGE_REVISION) \
		-v $(DIR)/Dockerfiles:/data \
		dsuite/alpine-data \
		sh -c "templater Dockerfile.template > Dockerfile-$(MARIADB_$(version)_MAJOR)"
	@docker build --force-rm \
		--file $(DIR)/Dockerfiles/Dockerfile-$(MARIADB_$(version)_MAJOR) \
		--tag $(DOCKER_IMAGE):$(MARIADB_$(version)_MAJOR) \
		$(DIR)/Dockerfiles
	@[ "$(version)" = "$(latest)" ] && docker tag $(DOCKER_IMAGE):$(MARIADB_$(version)_MAJOR) $(DOCKER_IMAGE):latest || true


test:  ## Test a specific version of mariadb ( make build v=10.5)
	@$(eval version := $(or $(v),$(latest)))
	@GOSS_FILES_PATH=$(DIR)/tests \
	GOSS_SLEEP=0.5 \
	 	dgoss run $(DOCKER_IMAGE):$(MARIADB_$(version)_MAJOR)

push-all: ## Push all supported versions
	@$(MAKE) push v=10.5
	@$(MAKE) push v=10.4
	@$(MAKE) push v=10.3
	@$(MAKE) push v=10.2
	@$(MAKE) push v=10.1

push: ## Push a specific version of mariadb ( make build v=10.5)
	@$(eval version := $(or $(v),$(latest)))
	@docker push $(DOCKER_IMAGE):$(MARIADB_$(version)_MAJOR)


shell: ## Get command prompt inside container
	@$(eval version := $(or $(v),$(latest)))
	@mkdir -p $(DIR)/tmp/db_config $(DIR)/tmp/db_data $(DIR)/tmp/db_backup $(DIR)/tmp/log
	@docker run -it --rm \
		-e DEBUG_LEVEL=DEBUG \
		-e MYSQL_ROOT_PASSWORD=rootpassword \
		-e MYSQL_DATABASE=TestBase \
		-e MYSQL_USER=test \
		-e MYSQL_PASSWORD=test \
		-e INNODB_LARGE_PREFIX=on       \
		-e INNODB_FILE_FORMAT=barracuda \
		-e INNODB_FILE_PER_TABLE=on     \
		-v $(DIR)/tmp/db_config:/mariadb/config \
		-v $(DIR)/tmp/db_data:/mariadb/data \
		-v $(DIR)/tmp/db_backup:/mariadb/backup \
		-v $(DIR)/tmp/log:/var/log \
		--name mariadb-$(version) \
		--entrypoint /bin/bash \
		$(DOCKER_IMAGE):$(MARIADB_$(version)_MAJOR)


remove: ## Remove all generated images
	@docker images | grep $(DOCKER_IMAGE) | tr -s ' ' | cut -d ' ' -f 2 | xargs -I {} docker rmi $(DOCKER_IMAGE):{} || true
	@docker images | grep $(DOCKER_IMAGE) | tr -s ' ' | cut -d ' ' -f 3 | xargs -I {} docker rmi {} || true


readme: ## Generate docker hub full description
	@docker run -t --rm \
		-e DEBUG_LEVEL=DEBUG \
		-e DOCKER_USERNAME=${DOCKER_USERNAME} \
		-e DOCKER_PASSWORD=${DOCKER_PASSWORD} \
		-e DOCKER_IMAGE=${DOCKER_IMAGE} \
		-v $(DIR):/data \
		dsuite/hub-updater

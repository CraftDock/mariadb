
## Current directory
DIR:=$(strip $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST)))))

##
.DEFAULT_GOAL := help
.PHONY: *


help: ## Display this help
	@printf "\n\033[33mUsage:\033[0m\n  make \033[32m<target>\033[0m \033[36m[\033[0marg=\"val\"...\033[36m]\033[0m\n\n\033[33mTargets:\033[0m\n"
	@awk 'BEGIN {FS = ":.*##"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[32m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

build: ## Build containers
	docker-compose --project-name example build

up: build ## Satrt containers
	docker-compose --project-name example up

down: ## Stop and remove containers
	docker-compose --project-name example down

remove:
	@rm -rf $(DIR)/.tmp
	@docker volume rm example_mariadb-data

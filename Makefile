#!make
DIR:=$(strip $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST)))))
PROJECT_NAME:=$(strip $(shell basename $(DIR)))
DOCKER_IMAGE=dsuite/$(PROJECT_NAME)

# env file
include $(DIR)/make.env


build: build-10.1 build-10.2 build-10.3 build-10.4

test: test-10.1 test-10.2 test-10.3 test-10.4

push: push-10.1 push-10.2 push-10.3 push-10.4


build-10.1:
	@docker run --rm \
		-e http_proxy=${http_proxy} \
		-e https_proxy=${https_proxy} \
		-e MARIADB_MAJOR=$(MARIADB_10_1_MAJOR) \
		-e MARIADB_VERSION=$(MARIADB_10_1_VERSION) \
		-v $(DIR)/Dockerfiles:/data \
		dsuite/alpine-data \
		sh -c "templater Dockerfile.template > Dockerfile-$(MARIADB_10_1_MAJOR)"
	@docker build \
		--build-arg http_proxy=${http_proxy} \
		--build-arg https_proxy=${https_proxy} \
		--file $(DIR)/Dockerfiles/Dockerfile-$(MARIADB_10_1_MAJOR) \
		--tag $(DOCKER_IMAGE):$(MARIADB_10_1_MAJOR) \
		$(DIR)/Dockerfiles

build-10.2:
	@docker run --rm \
		-e http_proxy=${http_proxy} \
		-e https_proxy=${https_proxy} \
		-e MARIADB_MAJOR=$(MARIADB_10_2_MAJOR) \
		-e MARIADB_VERSION=$(MARIADB_10_2_VERSION) \
		-v $(DIR)/Dockerfiles:/data \
		dsuite/alpine-data \
		sh -c "templater Dockerfile.template > Dockerfile-$(MARIADB_10_2_MAJOR)"
	@docker build \
		--build-arg http_proxy=${http_proxy} \
		--build-arg https_proxy=${https_proxy} \
		--file $(DIR)/Dockerfiles/Dockerfile-$(MARIADB_10_2_MAJOR) \
		--tag $(DOCKER_IMAGE):$(MARIADB_10_2_MAJOR) \
		$(DIR)/Dockerfiles

build-10.3:
	@docker run --rm \
		-e http_proxy=${http_proxy} \
		-e https_proxy=${https_proxy} \
		-e MARIADB_MAJOR=$(MARIADB_10_3_MAJOR) \
		-e MARIADB_VERSION=$(MARIADB_10_3_VERSION) \
		-v $(DIR)/Dockerfiles:/data \
		dsuite/alpine-data \
		sh -c "templater Dockerfile.template > Dockerfile-$(MARIADB_10_3_MAJOR)"
	@docker build \
		--build-arg http_proxy=${http_proxy} \
		--build-arg https_proxy=${https_proxy} \
		--file $(DIR)/Dockerfiles/Dockerfile-$(MARIADB_10_3_MAJOR) \
		--tag $(DOCKER_IMAGE):$(MARIADB_10_3_MAJOR) \
		$(DIR)/Dockerfiles

build-10.4:
	@docker run --rm \
		-e http_proxy=${http_proxy} \
		-e https_proxy=${https_proxy} \
		-e MARIADB_MAJOR=$(MARIADB_10_4_MAJOR) \
		-e MARIADB_VERSION=$(MARIADB_10_4_VERSION) \
		-v $(DIR)/Dockerfiles:/data \
		dsuite/alpine-data \
		sh -c "templater Dockerfile.template > Dockerfile-$(MARIADB_10_4_MAJOR)"
	@docker build \
		--build-arg http_proxy=${http_proxy} \
		--build-arg https_proxy=${https_proxy} \
		--file $(DIR)/Dockerfiles/Dockerfile-$(MARIADB_10_4_MAJOR) \
		--tag $(DOCKER_IMAGE):$(MARIADB_10_4_MAJOR) \
		$(DIR)/Dockerfiles
	@docker tag $(DOCKER_IMAGE):$(MARIADB_10_4_MAJOR) $(DOCKER_IMAGE):latest

test-10.1: build-10.1
	@docker run --rm -t \
		-e http_proxy=${http_proxy} \
		-e https_proxy=${https_proxy} \
		-v $(DIR)/tests:/goss \
		-v /tmp:/tmp \
		-v /var/run/docker.sock:/var/run/docker.sock \
		dsuite/goss:latest \
		dgoss run -e MYSQL_BACKUP_DIR=/mysql/backup -e MYSQL_LOG_DIR=/mysql/logs --entrypoint=/goss/entrypoint.sh $(DOCKER_IMAGE):$(MARIADB_10_1_MAJOR)

test-10.2: build-10.2
	@docker run --rm -t \
		-e http_proxy=${http_proxy} \
		-e https_proxy=${https_proxy} \
		-v $(DIR)/tests:/goss \
		-v /tmp:/tmp \
		-v /var/run/docker.sock:/var/run/docker.sock \
		dsuite/goss:latest \
		dgoss run -e MYSQL_BACKUP_DIR=/mysql/backup -e MYSQL_LOG_DIR=/mysql/logs --entrypoint=/goss/entrypoint.sh $(DOCKER_IMAGE):$(MARIADB_10_2_MAJOR)

test-10.3: build-10.3
	@docker run --rm -t \
		-e http_proxy=${http_proxy} \
		-e https_proxy=${https_proxy} \
		-v $(DIR)/tests:/goss \
		-v /tmp:/tmp \
		-v /var/run/docker.sock:/var/run/docker.sock \
		dsuite/goss:latest \
		dgoss run -e MYSQL_BACKUP_DIR=/mysql/backup -e MYSQL_LOG_DIR=/mysql/logs --entrypoint=/goss/entrypoint.sh $(DOCKER_IMAGE):$(MARIADB_10_3_MAJOR)

test-10.4: build-10.4
	@docker run --rm -t \
		-e http_proxy=${http_proxy} \
		-e https_proxy=${https_proxy} \
		-v $(DIR)/tests:/goss \
		-v /tmp:/tmp \
		-v /var/run/docker.sock:/var/run/docker.sock \
		dsuite/goss:latest \
		dgoss run -e MYSQL_BACKUP_DIR=/mysql/backup -e MYSQL_LOG_DIR=/mysql/logs --entrypoint=/goss/entrypoint.sh $(DOCKER_IMAGE):$(MARIADB_10_4_MAJOR)


push-10.1: build-10.1
	@docker push $(DOCKER_IMAGE):$(MARIADB_10_1_MAJOR)

push-10.2: build-10.2
	@docker push $(DOCKER_IMAGE):$(MARIADB_10_2_MAJOR)

push-10.3: build-10.3
	@docker push $(DOCKER_IMAGE):$(MARIADB_10_3_MAJOR)

push-10.4: build-10.4
	@docker push $(DOCKER_IMAGE):$(MARIADB_10_4_MAJOR)
	@docker push $(DOCKER_IMAGE):latest


shell-10.1: build-10.1
	@docker run -it --rm \
		-e http_proxy=${http_proxy} \
		-e https_proxy=${https_proxy} \
		-e DEBUG_LEVEL=DEBUG \
		-e MYSQL_ROOT_PASSWORD=rootpassword \
		-e MYSQL_DATABASE=TestBase \
		-e MYSQL_USER=test \
		-e MYSQL_PASSWORD=test \
		-e MYSQL_GENERAL_LOG=1 \
		-e MYSQL_SLOW_QUERY_LOG=1 \
		-e TIMEZONE=Europe/Paris \
		--name mariadb-10.1 \
		$(DOCKER_IMAGE):$(MARIADB_10_1_MAJOR) \
		bash

shell-10.2: build-10.2
	@docker run -it --rm \
		-e http_proxy=${http_proxy} \
		-e https_proxy=${https_proxy} \
		-e DEBUG_LEVEL=DEBUG \
		-e MYSQL_ROOT_PASSWORD=rootpassword \
		-e MYSQL_DATABASE=TestBase \
		-e MYSQL_USER=test \
		-e MYSQL_PASSWORD=test \
		-e MYSQL_GENERAL_LOG=1 \
		-e MYSQL_SLOW_QUERY_LOG=1 \
		-e TIMEZONE=Europe/Paris \
		--name mariadb-10.2 \
		$(DOCKER_IMAGE):$(MARIADB_10_2_MAJOR) \
		bash

shell-10.3: build-10.3
	@docker run -it --rm \
		-e http_proxy=${http_proxy} \
		-e https_proxy=${https_proxy} \
		-e DEBUG_LEVEL=DEBUG \
		-e MYSQL_ROOT_PASSWORD=rootpassword \
		-e MYSQL_DATABASE=TestBase \
		-e MYSQL_USER=test \
		-e MYSQL_PASSWORD=test \
		-e MYSQL_GENERAL_LOG=1 \
		-e MYSQL_SLOW_QUERY_LOG=1 \
		-e TIMEZONE=Europe/Paris \
		--name mariadb-10.3 \
		$(DOCKER_IMAGE):$(MARIADB_10_3_MAJOR) \
		bash

shell-10.4: build-10.4
	@docker run -it --rm \
		-e http_proxy=${http_proxy} \
		-e https_proxy=${https_proxy} \
		-e DEBUG_LEVEL=DEBUG \
		-e MYSQL_ROOT_PASSWORD=rootpassword \
		-e MYSQL_DATABASE=TestBase \
		-e MYSQL_USER=test \
		-e MYSQL_PASSWORD=test \
		-e MYSQL_GENERAL_LOG=1 \
		-e MYSQL_SLOW_QUERY_LOG=1 \
		-e TIMEZONE=Europe/Paris \
		--name mariadb-10.4 \
		$(DOCKER_IMAGE):$(MARIADB_10_4_MAJOR) \
		bash

remove:
	@docker images | grep $(DOCKER_IMAGE) | tr -s ' ' | cut -d ' ' -f 2 | xargs -I {} docker rmi $(DOCKER_IMAGE):{}

readme:
	@docker run -t --rm \
		-e http_proxy=${http_proxy} \
		-e https_proxy=${https_proxy} \
		-e DEBUG_LEVEL=DEBUG \
		-e DOCKER_USERNAME=${DOCKER_USERNAME} \
		-e DOCKER_PASSWORD=${DOCKER_PASSWORD} \
		-e DOCKER_IMAGE=${DOCKER_IMAGE} \
		-v $(DIR):/data \
		dsuite/hub-updater

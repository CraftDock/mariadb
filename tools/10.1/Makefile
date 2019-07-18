#!make
DIR:=$(strip $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST)))))
ROOT:=$(strip $(abspath $(DIR)/../..))
PROJECT_NAME:=$(strip $(shell basename $(ROOT)))
PROJECT_VERSION:=$(strip $(shell basename $(DIR)))
DOCKER_IMAGE=dsuite/$(PROJECT_NAME)
CONTAINER:=$(PROJECT_NAME)-$(PROJECT_VERSION)-test

# env file
include $(ROOT)/make.env


download:
	@mkdir -p $(DIR)/tmp
	@mkdir -p $(DIR)/tmp/patch
	@if [ ! -f "$(DIR)/tmp/mariadb.tar.gz" ]; then \
		docker run --rm -t \
			-e http_proxy=${http_proxy} \
			-e https_proxy=${https_proxy} \
			-v $(DIR)/tmp:/data \
			dsuite/alpine-data:latest sh -c "curl -fSL https://downloads.mariadb.com/MariaDB/mariadb-${MARIADB_10_1_VERSION}/source/mariadb-${MARIADB_10_1_VERSION}.tar.gz -o mariadb.tar.gz"; \
	fi

extract: download
	@rm -rf $(DIR)/tmp/mariadb
	@tar zxf $(DIR)/tmp/mariadb.tar.gz -C $(DIR)/tmp
	@mv $(DIR)/tmp/mariadb-${MARIADB_10_1_VERSION} $(DIR)/tmp/mariadb

diff:
	cd $(DIR)/tmp/mariadb; \
		diff -upZ --label 'scripts/CMakeLists.txt' --label 'scripts/CMakeLists.txt' scripts/CMakeLists.txt scripts/CMakeLists.txt.new > $(DIR)/tmp/patch/10-fix-mysql-install-db-path.patch; \
		diff -upZ --label 'configure.cmake' --label 'configure.cmake' configure.cmake configure.cmake.new > $(DIR)/tmp/patch/20-fix-ucontext-check.patch; \
		diff -upZ --label 'storage/innobase/include/ut0ut.h' --label 'storage/innobase/include/ut0ut.h' storage/innobase/include/ut0ut.h storage/innobase/include/ut0ut.h.new > $(DIR)/tmp/patch/30-ppc-remove-glibc-dep-check-innobase.patch; \
		diff -upZ --label 'storage/tokudb/PerconaFT/portability/toku_time.h' --label 'storage/tokudb/PerconaFT/portability/toku_time.h' storage/tokudb/PerconaFT/portability/toku_time.h storage/tokudb/PerconaFT/portability/toku_time.h.new > $(DIR)/tmp/patch/30-ppc-remove-glibc-dep-check-tokudb.patch; \
		diff -upZ --label 'storage/xtradb/include/ut0ut.h' --label 'storage/xtradb/include/ut0ut.h' storage/xtradb/include/ut0ut.h storage/xtradb/include/ut0ut.h.new > $(DIR)/tmp/patch/30-ppc-remove-glibc-dep-check-xtradb.patch; \
		diff -upZ --label 'cmake/pcre.cmake' --label 'cmake/pcre.cmake' cmake/pcre.cmake cmake/pcre.cmake.new > $(DIR)/tmp/patch/40-pcre.cmake.patch; \
		diff -upZ --label 'configure.cmake' --label 'configure.cmake' configure.cmake.new configure.cmake.new2 > $(DIR)/tmp/patch/50-c11-atomics-check.patch; \
		diff -upZ --label 'mysys/CMakeLists.txt' --label 'mysys/CMakeLists.txt' mysys/CMakeLists.txt mysys/CMakeLists.txt.new > $(DIR)/tmp/patch/51-c11-atomics-check.patch; \
		true

patch:
	cd $(DIR)/tmp/mariadb; \
		patch -p0 -i $(DIR)/tmp/patch/10-fix-mysql-install-db-path.patch -o scripts/CMakeLists.txt.new ; \
		patch -p0 -i $(DIR)/tmp/patch/20-fix-ucontext-check.patch -o configure.cmake.new ; \
		patch -p0 -i $(DIR)/tmp/patch/30-ppc-remove-glibc-dep-check-innobase.patch -o storage/innobase/include/ut0ut.h.new ; \
		patch -p0 -i $(DIR)/tmp/patch/30-ppc-remove-glibc-dep-check-tokudb.patch -o storage/tokudb/PerconaFT/portability/toku_time.h.new ; \
		patch -p0 -i $(DIR)/tmp/patch/30-ppc-remove-glibc-dep-check-xtradb.patch -o storage/xtradb/include/ut0ut.h.new ; \
		patch -p0 -i $(DIR)/tmp/patch/40-pcre.cmake.patch -o cmake/pcre.cmake.new ; \
		patch -p0 -i $(DIR)/tmp/patch/50-c11-atomics-check.patch -o configure.cmake.new2 ; \
		patch -p0 -i $(DIR)/tmp/patch/51-c11-atomics-check.patch -o mysys/CMakeLists.txt.new ;


build:
	@docker build \
		--build-arg http_proxy=${http_proxy} \
		--build-arg https_proxy=${https_proxy} \
		--file $(DIR)/Dockerfile \
		--tag $(DOCKER_IMAGE):$(PROJECT_VERSION)-test \
		$(DIR)

run:
	docker run -it --rm \
		-e http_proxy=${http_proxy} \
		-e https_proxy=${https_proxy} \
		--name $(CONTAINER) \
		$(DOCKER_IMAGE):$(PROJECT_VERSION)-test \
		bash

clean:
	rm -rf $(DIR)/tmp

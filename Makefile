PWD := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

PACKAGE := ethminer
GIT_USER := ethereum-mining
BRANCH := master
ARTIFACTS_PATH := artifacts
ABSOLUTE_ARTIFACTS_PATH := ${PWD}worker/${ARTIFACTS_PATH}
BINARY_PATH := ${ARTIFACTS_PATH}/${PACKAGE}

.PHONY: help build release

help: ## This helpfile
	@echo 'Usage: make [target] ...'
	@echo
	@echo 'Targets:'
	@echo
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

dev_build: ## Builds builder image, miner binary, and worker image. Uses cache.
	@docker build --build-arg PACKAGE=${PACKAGE} --build-arg GIT_USER=${GIT_USER} --build-arg BRANCH=${BRANCH} -t ethminer-builder builder/
	@docker run -v ${ABSOLUTE_ARTIFACTS_PATH}:/artifacts --rm -t ethminer-builder cp ${PACKAGE}/${PACKAGE} /artifacts/
	@docker build --build-arg BINARY_PATH=${BINARY_PATH} -t ethminer-worker worker/

build: ## Builds images from scratch
	@docker build --build-arg PACKAGE=${PACKAGE} --build-arg GIT_USER=${GIT_USER} --build-arg BRANCH=${BRANCH} -t z3n3z.azurecr.io/ethminer-builder builder/
	@docker run -v ${ABSOLUTE_ARTIFACTS_PATH}:/artifacts --rm -t z3n3z.azurecr.io/ethminer-builder cp ${PACKAGE}/${PACKAGE} /artifacts/
	@docker build --build-arg BINARY_PATH=${BINARY_PATH} -t z3n3z.azurecr.io/ethminer-worker worker/

release: build ## Builds images from scratch and pushes them to the hub
	@docker push z3n3z.azurecr.io/ethminer-builder
	@docker push z3n3z.azurecr.io/ethminer-worker
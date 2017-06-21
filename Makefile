PWD := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

PACKAGE := ethminer
GIT_USER := ethereum-mining
BRANCH := master
ARTIFACTS_PATH := artifacts
ABSOLUTE_ARTIFACTS_PATH := ${PWD}worker/${ARTIFACTS_PATH}
BINARY_PATH := ${ARTIFACTS_PATH}/${PACKAGE}

build:
	docker build --build-arg PACKAGE=${PACKAGE} --build-arg GIT_USER=${GIT_USER} --build-arg BRANCH=${BRANCH} -t ethminer-builder builder/
	docker run -v ${ABSOLUTE_ARTIFACTS_PATH}:/artifacts --rm -t ethminer-builder cp ${PACKAGE}/${PACKAGE} /artifacts/
	docker build --build-arg BINARY_PATH=${BINARY_PATH} -t ethminer-worker worker/
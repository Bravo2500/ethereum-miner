FROM nvidia/cuda:latest
LABEL Maintainer="Andrei Korzhuev <korzhuev@andrusha.me>"
LABEL Description="Ethereum GPU worker"

ARG BINARY_PATH

# RUN apt-get update
# RUN apt-get install idn -y

RUN mkdir ethminer
WORKDIR ethminer

COPY ${BINARY_PATH} ethminer
FROM nvidia/cuda:latest
LABEL Maintainer="Andrei Korzhuev <korzhuev@andrusha.me>"
LABEL Description="Ethereum GPU minerartifact builder"

ARG PACKAGE
ENV PACKAGE=${PACKAGE}
ARG GIT_USER
ENV GIT_USER=${GIT_USER}
ARG BRANCH
ENV BRANCH=${BRANCH}

# Packages
RUN apt-get update
RUN apt-get install -y --no-install-recommends wget cmake unzip build-essential

# Sources
RUN wget -q --no-check-certificate "https://codeload.github.com/${GIT_USER}/${PACKAGE}/zip/${BRANCH}"
RUN unzip "${BRANCH}"
WORKDIR "${PACKAGE}-${BRANCH}"

# Workdir
RUN mkdir build
WORKDIR build

# Build
RUN cmake -DBUNDLE=miner -DETHASHCUDA=ON -DETHASHCL=OFF -DETHSTRATUM=ON ..
RUN cmake --build .
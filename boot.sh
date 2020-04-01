#!/usr/bin/env bash

set -eu

# Check if application env file exists
APPLICATION_ENV_FILE=".env"
if [ ! -f "$(pwd)/$APPLICATION_ENV_FILE" ]; then
    printf "\n$APPLICATION_ENV_FILE file does not exist, please create it.\n\n"
    exit 1
fi

if !(which docker > /dev/null); then
    printf "\n...Docker must be installed...\n\n"
    exit 1
fi
if !(which docker-compose > /dev/null); then
    printf "\n...Docker Compose must be installed...\n\n"
    exit 1
fi

printf "\n...Cleaning up...\n\n"
docker rm $(docker ps -q -f 'status=exited') || true
docker rmi $(docker images -q -f 'dangling=true') || true
docker container stop $(docker container ls -a -q) || true
docker-compose down

printf "\n...Building...\n\n"
docker image build -t webapp . -f docker/Dockerfile

printf "\n...Cleaning up...\n\n"
docker rm $(docker ps -q -f 'status=exited') || true
docker rmi $(docker images -q -f 'dangling=true') || true

printf "\n...Spinning up Containers...\n\n"
docker-compose up -d
docker logs -f webapp

#!/bin/bash

docker rm -f master slave1 metadata
# docker network rm bigdata-in-docker_default
echo "Y" | docker volume prune
docker-compose up

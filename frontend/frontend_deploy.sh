#!/bin/bash
docker network create -d bridge sausage_network || true
docker login gitlab.praktikum-services.ru:5050 -u $DOCKER_GITLAB_USER -p $DOCKER_GITLAB_TOCKEN
docker pull gitlab.praktikum-services.ru:5050/std-013-59/sausage-store/sausage-frontend:latest

docker stop sausage-frontend || true
docker rm sausage-frontend || true
set -e
docker run -d --name sausage-frontend \
    --network=sausage_network \
    --restart always \
    -p 8443:80 \
    gitlab.praktikum-services.ru:5050/std-013-59/sausage-store/sausage-frontend:latest

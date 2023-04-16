#!/bin/bash
docker network create -d bridge sausage_network || true
docker login gitlab.praktikum-services.ru:3000 -u $DOCKER_GITLAB_USER -p $DOCKER_GITLAB_TOCKEN
docker pull gitlab.praktikum-services.ru:3000/std-013-59/sausage-store/sausage-frontend:$VERSION

docker stop sausage-frontend || true
docker rm sausage-frontend || true
set -e
docker run -d --name sausage-frontend \
    --network=sausage_network \
    --restart always \
    --env-file .env \
    -p 8082:80 \
    gitlab.praktikum-services.ru:3000/std-013-59/sausage-store/sausage-frontend:$VERSION
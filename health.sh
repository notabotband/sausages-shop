#!/bin/bash

set +e

sudo docker login -u ${REGISTRY_USER} -p ${REGISTRY_ACCESS_TOKEN} https://gitlab.praktikum-services.ru:5050/

if [ "$( sudo docker container inspect -f '{{.State.Health.Status}}' green )" == "healthy"] && ["$( sudo docker container inspect -f '{{.State.Health.Status}}' blue )" == "healthy"];
then [ sudo docker pull pull $CI_REGISTRY_IMAGE/sausage-backend:${VERSION} ] && [ sudo docker-compose stop green ] && [ sudo docker-compose --env-file /home/${DEV_USER}/.env_file up -d --scale green ] && [ sudo docker-compose stop blue ]
fi

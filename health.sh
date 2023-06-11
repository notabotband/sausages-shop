#!/bin/bash

set +e

sudo docker login -u ${REGISTRY_USER} -p ${REGISTRY_ACCESS_TOKEN} https://gitlab.praktikum-services.ru:5050/

if [ "$( sudo docker container inspect -f '{{.State.Health.Status}}' green )" == "healthy" ] && ["$( sudo docker container inspect -f '{{.State.Health.Status}}' blue )" == "healthy" ];
then [ sudo docker-compose --name green --env-file /home/${DEV_USER}/.env_file --project-directory /home/${DEV_USER}/ pull ] && [ sudo docker-compose stop green ] && [ sudo docker-compose --env-file /home/${DEV_USER}/.env_file up -d --scale green=3 blue=3 ] && [ sudo docker-compose stop blue ]
fi

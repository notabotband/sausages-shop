#!/bin/bash

set -e

sudo docker login -u ${REGISTRY_USER} -p ${REGISTRY_ACCESS_TOKEN} https://gitlab.praktikum-services.ru:5050/
sudo docker-compose --env-file /home/${DEV_USER}/.env_file --project-directory /home/${DEV_USER}/ pull
sudo docker-compose --env-file /home/${DEV_USER}/.env_file up -d --scale backend=3
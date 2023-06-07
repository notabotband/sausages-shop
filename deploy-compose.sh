#!/bin/bash

set -e

sudo docker login -u ${REGISTRY_USER} -p ${REGISTRY_ACCESS_TOKEN} https://gitlab.praktikum-services.ru:5050/
sudo docker-compose --env-file /home/${DEV_USER}/.env_file --project-directory /home/${DEV_USER}/ pull

sudo cp -rf /home/${DEV_USER}/sausage-store.service /etc/systemd/system/sausage-store.service
sudo systemctl daemon-reload
sudo systemctl restart sausage-store

sudo rm /home/${DEV_USER}/sausage-store.service
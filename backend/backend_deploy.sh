#!/bin/bash
set +e
cat > .env <<EOF
SPRING_DATASOURCE_USERNAME=${SPRING_DATASOURCE_USERNAME}
SPRING_DATASOURCE_PASSWORD=${SPRING_DATASOURCE_PASSWORD}
SPRING_DATA_MONGODB_URI=${SPRING_DATA_MONGODB_URI}
SPRING_VAULT_TOKEN=${SPRING_VAULT_TOKEN}
EOF

sudo docker network create -d bridge sausage_network || true
sudo docker login gitlab.praktikum-services.ru:5050 -u $DOCKER_GITLAB_USER -p $DOCKER_GITLAB_TOCKEN
sudo docker pull gitlab.praktikum-services.ru:5050/std-013-59/sausage-store/sausage-backend:latest
sudo docker stop sausage-backend || true
sudo docker rm sausage-backend || true
set -e
sudo docker run -d --name sausage-backend \
    --network=sausage_network \
    --restart always \
    --pull always \
    --env-file .env \
    gitlab.praktikum-services.ru:5050/std-013-59/sausage-store/sausage-backend:latest


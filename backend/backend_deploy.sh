#!/bin/bash
set +e
touch .env
cat > .env <<EOF
SPRING_DATASOURCE_USERNAME=${SPRING_DATASOURCE_USERNAME}
SPRING_DATASOURCE_PASSWORD=${SPRING_DATASOURCE_PASSWORD}
SPRING_DATA_MONGODB_URI=${SPRING_DATA_MONGODB_URI}
SPRING_DATASOURCE_URL=${SPRING_DATASOURCE_URL}
SPRING_DATASOURCE_PORT=${SPRING_DATASOURCE_PORT}
SPRING_DATASOURCE_NAME=${SPRING_DATASOURCE_NAME}
VAULT_TOKEN=${VAULT_TOKEN}
VAULT_HOST=${VAULT_HOST}
EOF

docker network create -d bridge sausage_network || true
docker login gitlab.praktikum-services.ru:5050 -u $DOCKER_GITLAB_USER -p $DOCKER_GITLAB_TOCKEN
docker pull gitlab.praktikum-services.ru:5050/std-013-59/sausage-store/sausage-backend:latest
docker stop sausage-backend || true
docker rm sausage-backend || true

set -e
docker run -d --name sausage-backend \
    --network=sausage_network \
    --restart always \
    --pull always \
    --env-file .env \
    gitlab.praktikum-services.ru:5050/std-013-59/sausage-store/sausage-backend:latest


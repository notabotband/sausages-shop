#! /bin/bash
#Если свалится одна из команд, рухнет и весь скрипт
set -xe
#Перезаливаем дескриптор сервиса на ВМ для деплоя
#sudo cp -rf sausage-store-frontend.service /etc/systemd/system/sausage-store-frontend.service
#sudo rm -f /home/front-user/sausage-store.tar.gz||true
#sudo rm -f /home/front-user/frontend||true
#Переносим артефакт в нужную папку
curl -u ${NEXUS_REPO_USER}:${NEXUS_REPO_PASS} -o sausage-store.tar.gz ${NEXUS_REPO_URL}/sausage-store-antipov-stanislav-frontend/sausage-store/${VERSION}/sausage-store-${VERSION}.tar.gz
sudo cp ./sausage-store.tar.gz /home/front-user/sausage-store.tar.gz||true #"<...>||true" говорит, если команда обвалится — продолжай#Обновляем конфиг systemd с помощью рестарта
sudo tar xvzf /home/front-user/sausage-store.tar.gz
sudo systemctl daemon-reload
#Перезапускаем сервис сосисочной
sudo systemctl restart sausage-store-frontend.service
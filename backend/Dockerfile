FROM openjdk:16-jdk-alpine
ARG VERSION=${VERSION}
WORKDIR /app
COPY ./sausage-store.jar ./sausage-store.jar
RUN apk --no-cache add curl \
    && apk add --no-cache dumb-init==1.2.5-r0 \
    && curl https://storage.yandexcloud.net/cloud-certs/CA.pem -o YandexInternalRootCA.crt \
    && keytool -importcert -file YandexInternalRootCA.crt \
    -alias yandex -cacerts -storepass changeit -noprompt \
    && rm -rf YandexInternalRootCA.crt \
    && addgroup --system student \
    && adduser -S -s /bin/false -G student student -D -H \
    && chown student:student ./sausage-store.jar
EXPOSE 8080
USER student
ENTRYPOINT ["dumb-init", "java", "-jar", "-Dmyserver.bindPort=8080", "./sausage-store.jar"]


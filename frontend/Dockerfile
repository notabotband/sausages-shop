FROM alpine:3.15 AS builder
WORKDIR /usr/src/app
COPY *.json ./
RUN apk add --no-cache npm==8.1.3-r0 \
    && npm install
COPY ./src ./src
RUN npm run build

FROM alpine:3.15 AS dependencies
WORKDIR /usr/src
COPY *.json ./
RUN apk add --no-cache npm==8.1.3-r0 \
    && npm install --only=production

FROM alpine:3.15
WORKDIR /usr/src/app
COPY --from=builder /usr/src/app/dist/frontend ./dist/frontend
COPY --from=dependencies /usr/node_modules ./node_modules
COPY package.json .
RUN apk add --no-cache npm==8.1.3-r0 \
    && npm install -g http-server@14.0.0

RUN npm install -g http-server && adduser -D www-data -u 1001
USER www-data
EXPOSE 80
ENTRYPOINT ["http-server", "dist/frontend/", "-p", "80", "--proxy", "http://sausage-backend:8080"]


FROM alpine:3.15 AS builder
WORKDIR /usr/src/app
COPY *.json ./
RUN apk add --no-cache npm==8.1.3-r0 \
    && npm install
COPY ./src ./src
RUN npm run build

#FROM nginxproxy/nginx-proxy:1.3.1

COPY --from=builder /usr/src/app/dist/frontend /usr/share/nginx/html

EXPOSE 80


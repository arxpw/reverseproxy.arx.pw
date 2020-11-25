FROM nginx:stable-alpine
RUN apk add nginx-mod-http-headers-more

COPY nginx.conf /etc/nginx/nginx.conf
COPY cors_support /etc/nginx
COPY ssl /etc/nginx/ssl

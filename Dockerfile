FROM nginx:stable-alpine
COPY nginx.conf /etc/nginx/nginx.conf
COPY cors_support /etc/nginx

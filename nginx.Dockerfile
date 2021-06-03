FROM nginx:latest

COPY nginx.http.config /etc/nginx/nginx.conf

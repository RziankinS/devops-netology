FROM nginx:latest

COPY config /etc/nginx
COPY ./index.html /usr/share/nginx/html

HEALTHCHECK --interval=30s --timeout=10s --retries=3 CMD curl -f http://localhost/ || exit 1

EXPOSE 80

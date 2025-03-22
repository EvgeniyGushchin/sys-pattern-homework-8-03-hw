FROM --platform=linux/amd64 nginx:latest 

COPY ./configuration /etc/nginx
COPY ./content /usr/share/nginx/html

HEALTHCHECK --interval=20s --timeout=10s --retries=5 CMD curl -f http://localhost/ || exit 1

EXPOSE 80
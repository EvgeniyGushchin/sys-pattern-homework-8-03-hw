FROM bitnami/nginx:1.25.5

WORKDIR /app

COPY index.html /app/index.html

USER root
ENTRYPOINT [ "/opt/bitnami/scripts/nginx/entrypoint.sh" ]
CMD [ "/opt/bitnami/scripts/nginx/run.sh" ]
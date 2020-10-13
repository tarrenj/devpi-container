FROM python:latest
LABEL maintainer="jake.tarren@gmail.com"

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod +x /usr/local/bin/entrypoint.sh \
    && pip3 install --upgrade --no-cache pip devpi-server==5.5.0 \
    devpi-web==4.0.5 \
    devpi-client==5.2.1 \
    && mkdir -p /root/.config/devpi-server/

COPY devpi-global.yml /root/.config/devpi-server/devpi-server.yml

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

FROM openjdk:8-jre-alpine

ENV TRACKCAR_VERSION 4.0
ENV TRACKCAR_WEB_VERSION 0.12.3
ENV MYSQL_HOST localhost
ENV MYSQL_PORT 3306
ENV MYSQL_DATABASE gtrackcar
ENV MYSQL_USER gtrackcar
ENV MYSQL_PASSWORD gtrackcar

WORKDIR /opt/gtrackcar

RUN set -ex && \
    apk add --no-cache wget mysql-client sed && \
    \
    wget -qO /tmp/gtrackcar.zip https://api.giahungtrieu.net/gtrackcar-other-4.0.zip && \
    unzip -qo /tmp/gtrackcar.zip -d /opt/gtrackcar && \
    wget -qO /opt/gtrackcar/gtrackcar-web.war https://github.com/vitalidze/traccar-web/releases/download/$TRACCAR_WEB_VERSION/traccar-web.war && \
    rm /tmp/gtrackcar.zip && \
    \
    apk del wget
    
COPY start.sh start.sh

VOLUME "/opt/gtrackcar/logs"

EXPOSE 8082
EXPOSE 5023-5023/tcp
EXPOSE 5023-5023/udp

ENTRYPOINT ["/bin/sh"]

CMD ["start.sh"]

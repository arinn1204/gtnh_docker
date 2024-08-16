FROM amazoncorretto:21-al2-jdk

WORKDIR /app

RUN yum -y update \
    && yum -y install unzip gzip tar vim find shadow-utils.x86_64 \
    && yum clean all \
    && rm -rf /var/cache/yum

ARG GTNH_VERSION=2.6.1
RUN curl "http://downloads.gtnewhorizons.com/ServerPacks/GT_New_Horizons_${GTNH_VERSION}_Server_Java_17-21.zip" -o server.zip
RUN unzip server.zip

RUN sed -i 's/eula=false/eula=true/' /app/eula.txt \
    && chmod +x /app/startserver-java9.sh

COPY /additional/mods /app/mods
COPY /additional/config /app/config
COPY /javaargs.txt /app/java9args.txt

RUN groupadd -g 1001 minecraft && useradd -g 1001 -u 1001 -M -d /app minecraft
RUN chown -R minecraft:minecraft /app

USER minecraft:minecraft

CMD ["./startserver-java9.sh"]

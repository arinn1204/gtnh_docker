FROM ghcr.io/graalvm/jdk-community:21

WORKDIR /app

RUN microdnf update \
    && microdnf install --nodocs unzip gzip bsdtar vim findutils \
    && microdnf clean all \
    && rm -rf /var/cache/yum

ARG GTNH_VERSION=2.6.1
RUN curl "http://downloads.gtnewhorizons.com/ServerPacks/GT_New_Horizons_${GTNH_VERSION}_Server_Java_17-21.zip" -o server.zip
RUN bsdtar zvfx server.zip


RUN sed -i 's/eula=false/eula=true/' /app/eula.txt \
    && chmod +x /app/startserver-java9.sh

COPY /additional/mods /app/mods
COPY /additional/config /app/config
COPY /javaargs.txt /app/java9args.txt

RUN groupadd -g 1001 minecraft && useradd -g 1001 -u 1001 -M -d /app minecraft
RUN chown -R minecraft:minecraft /app

USER minecraft:minecraft

CMD ["./startserver-java9.sh"]

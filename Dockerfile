FROM ghcr.io/graalvm/jdk-community:21

ARG GTNH_VERSION=2.5.1

RUN microdnf update \
    && microdnf install --nodocs unzip \
    && microdnf install --nodocs gzip \
    && microdnf install --nodocs bsdtar \
    && microdnf clean all \
    && rm -rf /var/cache/yum

WORKDIR /app

RUN curl "http://downloads.gtnewhorizons.com/ServerPacks/GT_New_Horizons_${GTNH_VERSION}_Server_Java_17-21.zip" | bsdtar -xvf-

RUN sed -i 's/eula=false/eula=true/' /app/eula.txt \
    && chmod +x /app/startserver-java9.sh

RUN groupadd -g 1001 minecraft && useradd -g 1001 -u 1001 -M -d /app minecraft
RUN chown -R minecraft:minecraft /app

USER minecraft:minecraft

CMD ["./startserver-java9.sh"]

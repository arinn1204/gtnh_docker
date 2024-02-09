FROM ghcr.io/graalvm/jdk-community:21

RUN microdnf update \
    && microdnf install --nodocs unzip \
    && microdnf install --nodocs gzip \
    && microdnf install --nodocs bsdtar \
    && microdnf clean all \
    && rm -rf /var/cache/yum

WORKDIR /app

ARG GTNH_VERSION=2.5.1
RUN curl "http://downloads.gtnewhorizons.com/ServerPacks/GT_New_Horizons_${GTNH_VERSION}_Server_Java_17-21.zip" | bsdtar -xvf-

RUN sed -i 's/eula=false/eula=true/' /app/eula.txt \
    && chmod +x /app/startserver-java9.sh


ARG SERVER_UTILITIES_VERSION=2.0.19
RUN curl -kL "https://github.com/GTNewHorizons/ServerUtilities/releases/download/${SERVER_UTILITIES_VERSION}/ServerUtilities-${SERVER_UTILITIES_VERSION}.jar" -o "mods/ServerUtilities-${SERVER_UTILITIES_VERSION}.jar"

RUN groupadd -g 1001 minecraft && useradd -g 1001 -u 1001 -M -d /app minecraft
RUN chown -R minecraft:minecraft /app

USER minecraft:minecraft

CMD ["./startserver-java9.sh"]

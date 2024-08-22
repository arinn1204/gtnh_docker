# Use ARG to define the base image, with amazoncorretto as default
ARG BASE_IMAGE
FROM ${BASE_IMAGE}

ARG BASE_IMAGE
ENV BASE_IMAGE=${BASE_IMAGE}

WORKDIR /app

# Install dependencies using the appropriate package manager
RUN if [[ "$BASE_IMAGE" == amazoncorretto* ]]; then \
        yum -y update && \
        yum -y install unzip vim find shadow-utils && \
        yum clean all && \
        rm -rf /var/cache/yum; \
    elif [[ "$BASE_IMAGE" == ghcr.io/graalvm/jdk-community* ]]; then \
        microdnf update && \
        microdnf install --nodocs unzip vim findutils && \
        microdnf clean all && \
        rm -rf /var/cache/yum; \
    else \
        echo "$BASE_IMAGE is not defined" && exit 1; \
    fi

# Download and extract the server pack
ARG GTNH_VERSION
RUN curl "http://downloads.gtnewhorizons.com/ServerPacks/GT_New_Horizons_${GTNH_VERSION}_Server_Java_17-21.zip" -o server.zip
RUN unzip server.zip

# Configure server
RUN sed -i 's/eula=false/eula=true/' /app/eula.txt && \
    chmod +x /app/startserver-java9.sh

# Copy additional files
COPY /additional/mods /app/mods
COPY /additional/config /app/config
COPY /additional/app /app
COPY /javaargs.txt /app/java9args.txt

# Set up user
RUN groupadd -g 1001 minecraft && \
    useradd -g 1001 -u 1001 -M -d /app minecraft && \
    chown -R minecraft:minecraft /app

USER minecraft:minecraft

CMD ["./startserver-java9.sh"]

FROM alpine:latest
WORKDIR /app
RUN apk add --no-cache ca-certificates wget unzip
RUN wget https://github.com/v2fly/v2ray-core/releases/latest/download/v2ray-linux-64.zip && \
    unzip v2ray-linux-64.zip && rm v2ray-linux-64.zip
COPY config.json /app/config.json
# FIX: This line makes sure the port matches what Google wants
RUN echo -e '#!/bin/sh\nsed -i "s/8080/$PORT/g" /app/config.json\n./v2ray run -c /app/config.json' > entrypoint.sh && chmod +x entrypoint.sh
ENTRYPOINT ["./entrypoint.sh"]

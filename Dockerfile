FROM alpine:3.12
MAINTAINER Jake Skeates <jake@skeat.es>

ARG TIPPECANOE_RELEASE="1.35.0"

RUN apk add --no-cache sudo git g++ make libgcc libstdc++ sqlite-libs sqlite-dev zlib-dev bash \
  && addgroup sudo && adduser -G sudo -D -H tippecanoe && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers \
  && cd /root \
  && git clone https://github.com/mapbox/tippecanoe.git tippecanoe \
  && cd tippecanoe \
  && git checkout tags/$TIPPECANOE_RELEASE \
  && cd /root/tippecanoe \
  && make \
  && make install \
  && cd /root \
  && rm -rf /root/tippecanoe \
  && apk del git g++ make sqlite-dev

USER tippecanoe
WORKDIR /home/tippecanoe
ENTRYPOINT /bin/bash
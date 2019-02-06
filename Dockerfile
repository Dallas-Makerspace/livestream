# Dockerfile for shoutcast
# VERSION               0.1

FROM alpine:latest

## TODO: Add org.schema.labels[]
## TODO: Add labels.net.dapla.cmdb[]

WORKDIR /opt/shoutcast

RUN mkdir -p control configs

ADD http://download.nullsoft.com/shoutcast/tools/sc_serv2_linux_x64-latest.tar.gz  /opt/shoutcast

#do not forget about /opt/shoutcast/sc_serv.conf
VOLUME ["/opt/shoutcast/control", "/opt/shoutcast/config"]

EXPOSE 8000/tcp 8001/tcp

CMD ["./sc_serv", "./config/sc_serv.conf"]

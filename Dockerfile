# Dockerfile for shoutcast
# VERSION               0.1

FROM debian:9.7-slim

## TODO: Add org.schema.labels[]
## TODO: Add labels.net.dapla.cmdb[]

WORKDIR /opt/shoutcast

## Resolves undocumented reversal of default behavior 
ADD http://download.nullsoft.com/shoutcast/tools/sc_serv2_linux_x64-latest.tar.gz  /opt/shoutcast/
RUN tar zxvf sc_serv2_linux_x64-latest.tar.gz && \
    rm sc_serv2_linux_x64-latest.tar.gz && \
    chmod +x sc_serv

#do not forget about /opt/shoutcast/sc_serv.conf
VOLUME ["/opt/shoutcast/control", "/opt/shoutcast/config"]

EXPOSE 8000/tcp
EXPOSE 8001/tcp

ENTRYPOINT /opt/shoutcast/sc_serv
CMD config/sc_serv.conf

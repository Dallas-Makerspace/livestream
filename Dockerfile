# Dockerfile for shoutcast
# VERSION               0.1

FROM debian:9.7-slim

# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG VCS_REF
ARG VERSION

LABEL org.label-schema.build-date=$BUILD_DATE \
  org.label-schema.name="livestream" \
  org.label-schema.description="Live Streaming Station in Docker" \
  org.label-schema.url="https://radio.testnet.dapla.net/" \
  org.label-schema.vcs-ref=$VCS_REF \
  org.label-schema.vcs-url="https://github.com/Dallas-Makerspace/livestream.git" \
  org.label-schema.vendor="Dallas Makerspace" \
  org.label-schema.version=$VERSION \
  org.label-schema.schema-version="1.0"

# Run-time metadata as defined at http://schema.dapla.net/cmdb
LABEL net.matrix.orgunit "Matrix NOC"
LABEL net.matrix.organization "Private Ops"
LABEL net.matrix.commonname "radio"
LABEL net.matrix.locality "Dallas"
LABEL net.matrix.state "Texas"
LABEL net.matrix.country "USA"
LABEL net.matrix.environment "<nonprod|production|staging>"
LABEL net.matrix.application "shoutcast"
LABEL net.matrix.role "media streaming"
LABEL net.matrix.owner "FC13F74B@matrix.net"
LABEL net.matrix.customer "PVT-01"
LABEL net.matrix.costcenter "INT-01"
LABEL net.matrix.oid "iso.org.dod.internet.42387"
LABEL net.matrix.duns "iso.org.duns.039271257"


WORKDIR /opt/shoutcast

## Resolves undocumented reversal of default behavior 
ADD http://download.nullsoft.com/shoutcast/tools/sc_serv2_linux_x64-latest.tar.gz  /opt/shoutcast/
RUN tar zxvf sc_serv2_linux_x64-latest.tar.gz && \
    rm sc_serv2_linux_x64-latest.tar.gz && \
    chmod +x sc_serv

#do not forget about /opt/shoutcast/sc_serv.conf
VOLUME /opt/shoutcast/control

EXPOSE 8000/tcp
EXPOSE 8001/tcp

#ENTRYPOINT /opt/shoutcast/sc_serv
CMD ['/opt/shoutcast/sc_serv', 'config/sc_serv.conf']

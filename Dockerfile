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
LABEL net.matrix.orgunit "Matrix NOC" \
      net.matrix.organization "Private Ops" \
      net.matrix.commonname "radio" \
      net.matrix.locality "Dallas" \
      net.matrix.state "Texas" \
      net.matrix.country "USA" \
      net.matrix.environment "<nonprod|production|staging>" \
      net.matrix.application "shoutcast" \
      net.matrix.role "media streaming" \
      net.matrix.owner "FC13F74B@matrix.net" \
      net.matrix.customer "PVT-01" \
      net.matrix.costcenter "INT-01" \
      net.matrix.oid "iso.org.dod.internet.42387" \
      net.matrix.duns "iso.org.duns.039271257"

WORKDIR /opt/shoutcast

## Resolves undocumented reversal of default behavior 
ADD http://download.nullsoft.com/shoutcast/tools/sc_serv2_linux_x64-latest.tar.gz  /opt/shoutcast/
COPY config/ /opt/shoutcast/config/
RUN tar zxvf sc_serv2_linux_x64-latest.tar.gz && \
    rm sc_serv2_linux_x64-latest.tar.gz && \
    chmod +x sc_serv

#do not forget about /opt/shoutcast/sc_serv.conf
VOLUME /opt/shoutcast/control

EXPOSE 8000/tcp
EXPOSE 8001/tcp

CMD ["./sc_serv", "config/sc_serv.conf"]

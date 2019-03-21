FROM lsiobase/alpine:latest
LABEL maintainer="burmjeff"

RUN echo "@edge http://nl.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories
RUN echo "@edgetesting http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories

RUN apk add --no-cache \
    ca-certificates \
    curl perl@edge \
    perl-html-parser@edge \
    perl-http-cookies@edge \
    perl-lwp-useragent-determined@edge \
    perl-json@edge \
    perl-json-xs@edgetesting \
    perl-lwp-protocol-https@edge \
    perl-uri@edge \
    ca-certificates@edge \
    perl-net-libidn@edge \
    perl-net-ssleay@edge \
    perl-io-socket-ssl@edge \
    perl-libwww@edge \
    perl-mozilla-ca@edge \
    perl-net-http@edge && \
    mkdir /data && \
    mkdir /cache && \
    curl -o \
    /app/xteve -L \
	"https://xteve.de:9443/download/?os=linux&arch=amd64&name=xteve&beta=false" && \
    chmod +x /app/xteve
    
ADD zap2xml.pl /app/zap2xml.pl

# environment variables
ENV XTEVE_PORT=34400 \
TVGUIDE_EPG=FALSE \
ZAP2XML_USERNAME= \
ZAP2XML_PASSWORD= \
ZAP2XML_ARGS="-D -I -F -L -T -O -b" \
XMLTV_FILENAME=xmltv.xml \
XML_UPDATE_INTERVAL=24

# add local files
COPY root/ /

# ports and volumes
VOLUME /config /data /cache
EXPOSE 34400

HEALTHCHECK --interval=5m --timeout=3s --retries=20 CMD /healthcheck.sh || exit 1

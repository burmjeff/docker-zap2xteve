FROM lsiobase/alpine:latest
LABEL maintainer="burmjeff"

RUN apk add --no-cache \
    ca-certificates \
    perl-dev \
    build-base \
    perl-html-parser \
    perl-http-cookies \
    perl-json \
    perl-lwp-protocol-https \
    perl-lwp-useragent-determined \
    ffmpeg \
    vlc \
    curl

RUN export PERL_MM_USE_DEFAULT=1 && \
    cpan -i JSON
RUN mkdir /data && \
    mkdir /cache

RUN wget https://github.com/xteve-project/xTeVe-Downloads/blob/master/xteve_linux_amd64.tar.gz?raw=true -O xteve_linux_amd64.tar.gz && \
    tar zxfvp xteve_linux_amd64.tar.gz -C /app && \
    rm -f xteve_linux_amd64.tar.gz && \
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

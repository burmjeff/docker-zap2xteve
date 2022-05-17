# syntax=docker/dockerfile:1

# First stage. Building a binary
# -----------------------------------------------------------------------------

# Base image for builder is debian 11 with golang 1.18+ pre-installed
FROM golang:1.18.1-bullseye AS builder

# Download the source code
RUN git clone https://github.com/SCP002/xTeVe.git /src
WORKDIR /src

# Install dependencies
RUN go mod download

# Compile
RUN go build xteve.go

# Second stage. Creating an image
# -----------------------------------------------------------------------------

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

# environment variables
ENV XTEVE_BIN=/home/xteve/bin \
XTEVE_HOME=/home/xteve \
XTEVE_TEMP=/tmp/xteve \
XTEVE_PORT=34400 \
ZAP2XML_HOME \
TVGUIDE_EPG=FALSE \
ZAP2XML_USERNAME= \
ZAP2XML_PASSWORD= \
ZAP2XML_ARGS="-D -I -F -L -T -O -b" \
XMLTV_FILENAME=xmltv.xml \
XML_UPDATE_INTERVAL=24

ADD zap2xml.pl $ZAP2XML_HOME/zap2xml.pl

# Copy built binary from builder image
COPY --from=builder [ "/src/xteve", "${XTEVE_BIN}/" ]

# Set binary permissions
RUN chmod +rx $XTEVE_BIN/xteve

# Create XML cache directory
RUN mkdir $XTEVE_HOME/cache

# Create working directories for xTeVe
RUN mkdir /config
RUN chmod a+rwX /config
RUN mkdir $XTEVE_TEMP
RUN chmod a+rwX $XTEVE_TEMP

# add local files
COPY root/ /

# ports and volumes
VOLUME /config /data $XTEVE_TEMP $ZAP2XML_HOME
EXPOSE 34400

HEALTHCHECK --interval=5m --timeout=3s --retries=20 CMD /healthcheck.sh || exit 1
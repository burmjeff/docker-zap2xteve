# syntax=docker/dockerfile:1

# First stage. Building a binary
# -----------------------------------------------------------------------------

# Base image for builder is debian 11 with golang 1.18+ pre-installed
FROM golang:1.18.2-bullseye AS builder

# Download the source code
#RUN git clone https://github.com/SCP002/xTeVe.git /src
COPY xteve/ /src
WORKDIR /src

# Install dependencies
RUN go mod download

# Compile
RUN CGO_ENABLED=0 go build xteve.go

# Second stage. Creating an image
# -----------------------------------------------------------------------------

FROM lsiobase/alpine:3.15
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
ENV HOST_IP= \
XTEVE_TEMP=/tmp/xteve \
XTEVE_PORT=34400 \
TVGUIDE_EPG=FALSE \
ZAP2XML_USERNAME= \
ZAP2XML_PASSWORD= \
ZAP2XML_ARGS="-D -I -F -L -T -O -b" \
XMLTV_FILENAME=xmltv.xml \
XML_UPDATE_INTERVAL=24

RUN mkdir -p /xteve
RUN mkdir -p /zap2xml

# Add binary to PATH
ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/xteve/bin

# Set working directory
WORKDIR /xteve

ADD zap2xml.pl /

# Copy built binary from builder image
COPY --from=builder /src/xteve /xteve/bin/xteve

# Set binary permissions
RUN chmod +rx /xteve/bin/xteve

# Create XML cache directory
RUN mkdir /xteve/cache

# Create working directories for xTeVe
RUN mkdir -p /config
RUN chmod a+rwX /config
RUN mkdir $XTEVE_TEMP
RUN chmod a+rwX $XTEVE_TEMP
Run mkdir /zap2xml/cache


# add local files
COPY root/ /

# ports and volumes
VOLUME /config $XTEVE_TEMP /zap2xml
EXPOSE 34400

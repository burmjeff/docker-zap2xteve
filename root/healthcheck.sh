#!/bin/sh -e

CURL_OPTS="--connect-timeout 15 --silent --show-error --fail"

curl ${CURL_OPTS} "http://localhost:${XTEVE_PORT}/web" >/dev/null

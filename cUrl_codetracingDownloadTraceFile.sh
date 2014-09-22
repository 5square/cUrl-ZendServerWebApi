#!/bin/sh

API_METHOD=codetracingDownloadTraceFile

HOST=10.11.12.102
PORT=10081
USER_AGENT=MyCurlUserAgent
API_KEY=admin
API_SECRET=93318a59369f2bb99e067026be26351ccbfae61ab70c0231f200d289fed4b30c

TRACE_FILE=0.8366.1

URL_PATH=/ZendServer/Api/$API_METHOD
DATE=`LC_ALL=en_US.utf8 date -u +"%a, %d %b %Y %T GMT"`

DATA="$HOST:$PORT:$URL_PATH:$USER_AGENT:$DATE"

SIGNATURE=$(echo -n "$DATA" | openssl sha256 -hmac "$API_SECRET")
SIGNATURE=${SIGNATURE#*= }

curl \
-H "User-agent: $USER_AGENT" \
-H "Host: $HOST:$PORT" \
-H "Date: $DATE" \
-H "Accept: application/vnd.zend.serverapi+xml;version=1.8" \
-H "X-Zend-Signature: $API_KEY;$SIGNATURE" \
http://$HOST:$PORT$URL_PATH?traceFile=$TRACE_FILE


#!/bin/bash

if [ "${__variables__}" = true ] ; then
    return 0
fi

. __utils__.sh

## parse arguments

until [ $# -eq 0 ]
do
  name=${1:1}; shift;
  if [[ -z "$1" || $1 == -* ]] ; then eval "export $name=''"; else eval "export $name=$1"; shift; fi
done

if [ -z "${credentials}" ] || [ -z "${url}" ]; then
    log "sample usage:" "<script> -credentials <aws_access_key>:<aws_secret_key> -url <c_url>"
    exit 1
fi

readonly aws_access_key=$(cut -d':' -f1 <<<"${credentials}")
readonly aws_secret_key=$(cut -d':' -f2 <<<"${credentials}")
readonly api_url="${url}"
log "aws_access_key=" "${aws_access_key}"
log "aws_secret_key=" "${aws_secret_key}"
log "api_url=" "${url}"

readonly today=$(date -u +"%Y%m%d") #20171226
readonly timestamp=$(date -u +"%Y%m%dT%H%M%SZ") #"20171226T112335Z"

readonly api_host=$(printf ${api_url} | awk -F/ '{print $3}')
readonly api_uri=$(printf ${api_url} | grep / | cut -d/ -f4-)

readonly aws_region=$(cut -d'.' -f3 <<<"${api_host}")
readonly aws_service=$(cut -d'.' -f2 <<<"${api_host}")

readonly algorithm="AWS4-HMAC-SHA256"
readonly credential_scope="${today}/${aws_region}/${aws_service}/aws4_request"

readonly signed_headers="host;x-amz-date"
readonly header_x_amz_date="x-amz-date:${timestamp}"

__variables__=true

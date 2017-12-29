#!/bin/bash

if [ "${__utils__}" = true ] ; then
    return 0
fi

function sha256Hash() {
  local output=$(printf "$1" | openssl dgst -sha256)
  printf "${output}"
}

function log() {
    local message="$1"
    local details="$2"

    printf "${message}\n" >&2
    printf "${details}\n\n" | sed 's/^/    /' >&2
}

function hmac_sha256() {
   printf "$2" | openssl dgst -binary -hex -sha256 -mac HMAC -macopt hexkey:"$1"
}

__utils__=true

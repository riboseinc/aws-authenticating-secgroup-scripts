#!/bin/bash

if [ "${__utils__}" = true ] ; then
    return 0
fi

function sha256Hash() {
    printf "$1" | ${OPENSSL_BIN} dgst -sha256 -binary -hex | sed 's/^.* //'
}

function log() {
    local message="$1"
    local details="$2"

    printf "${message}\n" >&2
    printf "${details}\n\n" | sed 's/^/    /' >&2
}

to_hex() {
    printf "$1" | od -A n -t x1 | tr -d [:space:]
}

function hmac_sha256() {
    printf "$2" | \
        ${OPENSSL_BIN} dgst -binary -hex -sha256 -mac HMAC -macopt hexkey:"$1" | \
        sed 's/^.* //'
}

__utils__=true

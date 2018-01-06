#!/bin/bash

if [ "${__utils__}" = true ] ; then
    return 0
fi

function sha256Hash() {
    printf "$1" | ${OPENSSL_BIN} dgst -sha256 -binary | xxd -p -c 256
}

function log() {
    local message="$1"
    local details="$2"

    printf "${message}\n" >&2
    printf "${details}\n\n" | sed 's/^/    /' >&2
}

function hmac_sha256() {
    printf "$2" | ${OPENSSL_BIN} dgst -binary -sha256 -mac HMAC -macopt hexkey:"$1" | xxd -p -c 256
}

__utils__=true

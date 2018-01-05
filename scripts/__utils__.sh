#!/bin/bash

if [ "${__utils__}" = true ] ; then
    return 0
fi

function sha256Hash() {
  uname | grep -q ^Darwin
  if [ $? -eq 0 ]; then
    local output="$(printf "$1" | ${OPENSSL_BIN} dgst -sha256 -binary | xxd -p -c 256)"
  else
    local output="$(printf "$1" | ${OPENSSL_BIN} dgst -sha256)"
  fi

  echo "${output}"
}

function log() {
    local message="$1"
    local details="$2"

    printf "${message}\n" >&2
    printf "${details}\n\n" | sed 's/^/    /' >&2
}

function hmac_sha256() {
  uname | grep -q ^Darwin
  if [ $? -eq 0 ]; then
    local hash="$(printf "$2" | ${OPENSSL_BIN} dgst -binary -sha256 -mac HMAC -macopt hexkey:"$1" | xxd -p -c 256)"
  else
    local hash="$(printf "$2" | openssl dgst -binary -hex -sha256 -mac HMAC -macopt hexkey:"$1")"
  fi

  echo "${hash}"
}

__utils__=true

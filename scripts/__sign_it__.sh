#!/bin/bash

## AWS Signature v4
## http://docs.aws.amazon.com/apigateway/api-reference/signing-requests/

if [ "${__sign_it__}" = true ] ; then
    return 0
fi

. __utils__.sh
. __variables__.sh

## http://docs.aws.amazon.com/general/latest/gr/sigv4-create-canonical-request.html
function task_1() {
    local http_request_method="$1"
    local canonical_uri="/${api_uri}"
    local canonical_query=""

    local header_host="host:${api_host}"
    local canonical_headers="${header_host}\n${header_x_amz_date}"

    local request_payload=$(sha256Hash "")
    local canonical_request="${http_request_method}\n${canonical_uri}\n${canonical_query}\n${canonical_headers}\n\n${signed_headers}\n${request_payload}"

    log "canonical_request=" "${canonical_request}"
    printf "$(sha256Hash ${canonical_request})"
}

## http://docs.aws.amazon.com/general/latest/gr/sigv4-create-string-to-sign.html
function task_2() {
    local hashed_canonical_request="$1"
    local sts="${algorithm}\n${timestamp}\n${credential_scope}\n${hashed_canonical_request}"
    log "string_to_sign=" "${sts}"
    printf "${sts}"
}

## http://docs.aws.amazon.com/general/latest/gr/sigv4-calculate-signature.html
function task_3() {
    local secret=$(to_hex "AWS4${aws_secret_key}")
    local k_date=$(hmac_sha256 "${secret}" "${today}")
    local k_region=$(hmac_sha256 "${k_date}" "${aws_region}")
    local k_service=$(hmac_sha256 "${k_region}" "${aws_service}")
    local k_signing=$(hmac_sha256 "${k_service}" "aws4_request")
    local string_to_sign="$1"

    local signature=$(hmac_sha256 "${k_signing}" "${string_to_sign}" | sed 's/^.* //')
    log "signature=" "${signature}"
    printf "${signature}"
}

## http://docs.aws.amazon.com/general/latest/gr/sigv4-add-signature-to-request.html#sigv4-add-signature-auth-header
function task_4() {
    local credential="Credential=${aws_access_key}/${credential_scope}"
    local s_headers="SignedHeaders=${signed_headers}"
    local signature="Signature=$1"

    local authorization_header="Authorization: ${algorithm} ${credential}, ${s_headers}, ${signature}"
    log "authorization_header=" "${authorization_header}"
    printf "${authorization_header}"
}

function sign_it() {
    local method="$1"
    local hashed_canonical_request=$(task_1 "${method}")
    local string_to_sign=$(task_2 "${hashed_canonical_request}")
    local signature=$(task_3 "${string_to_sign}")
    local authorization_header=$(task_4 "${signature}")
    printf "${authorization_header}"
}

__sign_it__=true

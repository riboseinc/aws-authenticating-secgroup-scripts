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

## stolen from http://wp.vpalos.com/537/uri-parsing-using-bash-built-in-features/
function uri_parser() {
    # uri capture
    local uri="$@"

    # safe escaping
    uri="${uri//\`/%60}"
    uri="${uri//\"/%22}"

    # top level parsing
    local pattern='^(([a-z]{3,5})://)?((([^:\/]+)(:([^@\/]*))?@)?([^:\/?]+)(:([0-9]+))?)(\/[^?]*)?(\?[^#]*)?(#.*)?$'
    [[ "$uri" =~ $pattern ]] || return 1;

    # component extraction
    uri=${BASH_REMATCH[0]}
    local uri_schema=${BASH_REMATCH[2]}
    local uri_address=${BASH_REMATCH[3]}
    local uri_user=${BASH_REMATCH[5]}
    local uri_password=${BASH_REMATCH[7]}
    local uri_host=${BASH_REMATCH[8]}
    local uri_port=${BASH_REMATCH[10]}
    local uri_path=${BASH_REMATCH[11]}
    local uri_query=${BASH_REMATCH[12]}
    local uri_fragment=${BASH_REMATCH[13]}

    # path parsing
    local count=0
    local path="$uri_path"
    pattern='^/+([^/]+)'
    while [[ $path =~ $pattern ]]; do
        eval "uri_parts[$count]=\"${BASH_REMATCH[1]}\""
        path="${path:${#BASH_REMATCH[0]}}"
        let count++
    done

    # query parsing
    count=0
    local query="$uri_query"
    pattern='^[?&]+([^= ]+)(=([^&]*))?'
    while [[ $query =~ $pattern ]]; do
        eval "uri_args[$count]=\"${BASH_REMATCH[1]}\""
        eval "uri_arg_${BASH_REMATCH[1]}=\"${BASH_REMATCH[3]}\""
        query="${query:${#BASH_REMATCH[0]}}"
        let count++
    done

    # return success
#    return 0
    printf "{"path": "${path}", "query": "${query}"}"
}

__utils__=true

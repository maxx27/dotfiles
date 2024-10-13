#!/bin/bash -ex
if [ $# -ne 1 ]; then
    >&2 echo "usage: $0 host.url"
    exit 1
fi

openssl s_client -showcerts -servername $1 -connect $1:443 </dev/null

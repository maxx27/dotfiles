#!/bin/bash -ex
if [ $# -ne 1 ]; then
    >&2 echo "usage: $0 host.url"
    exit 1
fi

# -verify 5
[ -e $1 ] && rm -rf $1
mkdir -p $1
pushd $1
openssl s_client -showcerts -servername $1 -connect $1:443 </dev/null | \
    awk '/BEGIN CERTIFICATE/,/END CERTIFICATE/{ if(/BEGIN CERTIFICATE/){a++}; out="cert"a".pem"; print >out}'
popd

# for cert in *.pem; do
#    newname=$(openssl x509 -noout -subject -in $cert | sed -nE 's/.*CN ?= ?(.*)/\1/; s/[ ,.*]/_/g; s/__/_/g; s/_-_/-/; s/^_//g;p' | tr '[:upper:]' '[:lower:]').pem
#    mv $cert $newname
# done

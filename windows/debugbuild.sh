#!/bin/bash

cmd() {
    echo "[#] $*" >&2
    "$@"
}

die() {
    echo "[!] $*" >&2
    exit 1
}


for i in Dockerfile.* ; do
    buildname=$(cat $i | grep "^FROM " | tail -n1 | awk -F' AS ' '{print $2}' )

    DOCKER_BUILDKIT=1 cmd docker build --progress=plain -t ${buildname} -f $i .
done;


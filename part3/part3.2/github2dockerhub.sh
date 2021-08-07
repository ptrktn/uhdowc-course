#!/bin/bash

[ 2 -ne $# ] && {
    echo >&2 "Required arguments: REPOSITORY HUBUSER"
    exit 1
}

REPO=$1
HUBUSER=$2

echo "Cloning $REPO"
git clone $REPO

dockerfile=$(find . -type f -name Dockerfile | sort | head -n 1)

[ -z "$dockerfile" ] && {
    echo >&2 "Dockerfile not found"
    exit 1
}

imgname="${HUBUSER}/github2dockerhub-$(basename $(dirname $dockerfile))"

echo "Creating $imgname from $dockerfile"

( cd $(dirname $dockerfile) && docker build . -t "$imgname" ) || {
    echo >&2 "Build failed"
    exit 1
}

docker login -u $HUBUSER

docker push $imgname || {
    echo >&2 "Push failed"
    exit 1
}









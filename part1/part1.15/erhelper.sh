#!/bin/bash

if [ 1 -eq $# ] ; then
    MODEL_URL="$1"
else
    MODEL_URL="https://raw.githubusercontent.com/ptrktn/bz/main/erhelper/examples/lotka-volterra.txt"
fi

echo "/* Fetching $MODEL_URL */"

curl -s -L -O "$MODEL_URL"

FNAME=$(basename $MODEL_URL)

if [ -r "$FNAME" ] ; then
    python2 erhelper.py $FNAME
    cat erhelper.h
else
    echo "/* Failed */"
fi

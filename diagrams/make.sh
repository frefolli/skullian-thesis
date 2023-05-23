#!/bin/bash

LAYOUT=elk
# layouts: elk, dagre

FORCE="false"

function compile() {
    for d2file in $(find . -name "*.d2"); do
        svgfile=$(echo -e $d2file | sed "s/.d2/.svg/")
        if [ $d2file -nt $svgfile ] || [ $FORCE = "true" ]; then
            echo -e "d2 $d2file -l elk"
            d2 $d2file -l $LAYOUT
            echo -e "$d2file [DONE]"
        else
            echo -e "$d2file [KEEP]"
        fi
    done
}

function clean() {
    for d2file in $(find . -name "*.d2"); do
        svgfile=$(echo -e $d2file | sed "s/.d2/.svg/")
        rm -r $svgfile
    done
}

ARG=$2
if [ "$ARG" = "-f" ]; then
    FORCE="true"
fi

COMM=$1
if [ "$COMM" = "build" ]; then
    compile
elif [ "$1" = "clean" ]; then
    clean
fi

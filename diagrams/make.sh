#!/bin/bash

LAYOUT=dagre
# layouts: elk, dagre

FORCE="false"

function play() {
    COMM=$1
    echo $1
    $1
}

function compile() {
    for d2file in $(find . -name "*.d2"); do
        # svgfile=$(echo -e $d2file | sed "s/.d2/.svg/")
        pngfile=$(echo -e $d2file | sed "s/.d2/.png/")
        if [ $d2file -nt $pngfile ] || [ $FORCE = "true" ]; then
            # play "d2 $d2file -l $LAYOUT $svgfile"
            play "d2 $d2file -l $LAYOUT $pngfile"
            echo -e "$d2file [DONE]"
        else
            echo -e "$d2file [KEEP]"
        fi
    done
}

function clean() {
    for d2file in $(find . -name "*.d2"); do
        svgfile=$(echo -e $d2file | sed "s/.d2/.svg/")
        pngfile=$(echo -e $d2file | sed "s/.d2/.png/")
        rm -f $svgfile $pngfile
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

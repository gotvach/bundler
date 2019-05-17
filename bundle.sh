#!/bin/bash

MODULES_DIR=${MODULES_DIR:-.}
MODULE=${MODULE:-.}
CACHE_PATH=${CACHE_PATH:-.vendor}

cd /$MODULES_DIR/$MODULE

case $1 in
    install)
        bundle $@ --path $CACHE_PATH
        ;;
    *)
        bundle ${@:---help}
        ;;
esac

#!/bin/bash

DIST_DIR=dist
CORE_DIR=../freesheet

echo Building dependencies

mkdir -p $DIST_DIR

(cd $CORE_DIR && ./build)

cp $CORE_DIR/$DIST_DIR/freesheet.js ./$DIST_DIR


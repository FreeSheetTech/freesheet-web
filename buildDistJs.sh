#!/bin/bash

DIST_FILE=dist/freesheet-web.js
DIST_DIR=$(dirname $DIST_FILE)
FSW_FILE=$DIST_DIR/fsw.js
METEOR_FILE=$DIST_DIR/meteor-lite.js

echo Building distribution file $DIST_FILE

mkdir -p $DIST_DIR

cat \
    ./src/main/js/template/meteor-skeleton.js \
    ./src/main/js/template/underscore.js \
    ./src/main/js/template/tracker.js \
    ./src/main/js/template/htmljs.js \
    ./src/main/js/template/html-tools.js \
    ./src/main/js/template/reactive-var.js \
    ./src/main/js/template/id-map.js \
    ./src/main/js/template/base64.js \
    ./src/main/js/template/ejson.js \
    ./src/main/js/template/minimongo.js \
    ./src/main/js/template/observe-sequence.js \
    ./src/main/js/template/blaze.js \
    ./src/main/js/template/blaze-tools.js \
    ./src/main/js/template/templating.js \
    ./src/main/js/template/spacebars-compiler.js \
    ./src/main/js/template/spacebars.js \
    ./src/main/js/template/reactive-dict.js \
  > $METEOR_FILE

node_modules/.bin/browserify -o $FSW_FILE \
  -x freesheet -x freesheet-errors -x core-functions -x time-functions \
  -r ./src/main/js/web/FreesheetWeb.js:freesheet-web \
  -r ./src/main/js/web/PageInputs.js:page-inputs \
  -r ./src/main/js/worksheet/FileUtils.js:file-utils \
  -r ./src/main/js/worksheet/TableWorksheet.js:table-worksheet \
  -r ./src/main/js/template/reactive-dict.js \
  -r ./src/main/js/template/ReactiveTemplate.js:reactive-template

cat \
    ./src/main/js/lib/handsontable.full.js \
    ./src/main/js/lib/FileSaver.js \
    $METEOR_FILE \
    $FSW_FILE \
  > $DIST_FILE
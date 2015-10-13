#!/bin/bash

DIST_DIR=dist
DIST_JS_FILE=$DIST_DIR/freesheet-web.js
ALL_JS_FILE=$DIST_DIR/freesheet-all.js
DIST_CSS_FILE=$DIST_DIR/freesheet.css
FSW_FILE=$DIST_DIR/fsw.js
METEOR_FILE=$DIST_DIR/meteor-lite.js

echo Building distribution files

mkdir -p $DIST_DIR

cat \
    ./lib/js/template/meteor-skeleton.js \
    ./lib/js/template/underscore.js \
    ./lib/js/template/tracker.js \
    ./lib/js/template/htmljs.js \
    ./lib/js/template/html-tools.js \
    ./lib/js/template/reactive-var.js \
    ./lib/js/template/id-map.js \
    ./lib/js/template/base64.js \
    ./lib/js/template/ejson.js \
    ./lib/js/template/minimongo.js \
    ./lib/js/template/observe-sequence.js \
    ./lib/js/template/blaze.js \
    ./lib/js/template/blaze-tools.js \
    ./lib/js/template/templating.js \
    ./lib/js/template/spacebars-compiler.js \
    ./lib/js/template/spacebars.js \
    ./lib/js/template/reactive-dict.js \
  > $METEOR_FILE

node_modules/.bin/browserify -o $FSW_FILE \
  -x freesheet -x freesheet-errors -x core-functions -x time-functions \
  -r ./target/coffeejs/web/FreesheetWeb.js:freesheet-web \
  -r ./target/coffeejs/web/ReactiveTemplate.js:reactive-template \
  -r ./target/coffeejs/web/PageInputs.js:page-inputs \
  -r ./target/coffeejs/worksheet/FileUtils.js:file-utils \
  -r ./target/coffeejs/worksheet/TableWorksheet.js:table-worksheet \
  -r ./lib/js/template/reactive-dict.js

cat \
    ./lib/js/handsontable.full.js \
    ./lib/js/FileSaver.js \
    $METEOR_FILE \
    $FSW_FILE \
  > $DIST_JS_FILE

cat \
    $DIST_DIR/freesheet.js \
    $DIST_JS_FILE \
  > $ALL_JS_FILE

cat \
    ./src/main/css/freesheet-web.css \
    ./src/main/css/freesheet-edit.css \
  > $DIST_CSS_FILE
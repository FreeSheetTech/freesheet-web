#!/bin/bash

DIST_FILE=dist/freesheet-web.js
echo Building distribution file $DIST_FILE

mkdir -p $(dirname $DIST_FILE)

node_modules/.bin/browserify -o $DIST_FILE \
  -x freesheet -x freesheet-errors -x core-functions -x time-functions \
  -r ./src/main/js/web/FreesheetWeb.js:freesheet-web \
  -r ./src/main/js/web/PageFunctions.js:page-functions \
  -r ./src/main/js/worksheet/FileUtils.js:file-utils \
  -r ./src/main/js/worksheet/TableWorksheet.js:table-worksheet

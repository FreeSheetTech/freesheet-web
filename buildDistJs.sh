#!/bin/bash

mkdir -p dist

browserify -o dist/freesheet-web.js \
  -x freesheet -x core-functions -x page-functions -x time-functions \
  -r ./src/main/js/web/FreesheetWeb.js:freesheet-web \
  -r ./src/main/js/worksheet/FileUtils.js:file-utils \
  -r ./src/main/js/worksheet/TableWorksheet.js:table-worksheet

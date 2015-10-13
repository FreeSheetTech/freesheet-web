#!/usr/bin/env bash

set -e

echo Compiling coffeescript

for d in $(ls src/main/js)
do
 echo "Compiling main/$d"
 coffee --map -o target/coffeejs/$d -c src/main/js/$d/*.coffee
done

for d in $(ls src/test/js)
do
 echo "Compiling test/$d"
 coffee --map -o target/coffeejs/$d -c src/test/js/$d/*.coffee
done


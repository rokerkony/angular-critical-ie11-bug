#!/bin/bash
set -e
_NAME="critical:"

## make sure you have clean exit for npm run and CI
echo "$_NAME checking script dependencies"
SCRIPTNAME=${0##*/}

FIND=$(command -v find) || { echo "$_NAME $SCRIPTNAME: find is not available"; exit 1; }
CSS_FILENAME=$(${FIND} dist -name "*.css")

echo "$_NAME filter and add critical css as inline"
cp ./dist/index.html ./dist/index-source.html
rm -f ./dist/index.html
cat ./dist/index-source.html | ./node_modules/.bin/critical --minify \
                                                            --base dist \
                                                            --ignore @font-face \
                                                            --ignore @-ms-viewport \
                                                            --ignore @charset \
                                                            --css ${CSS_FILENAME} \
                                                            --folder dist \
                                                            --width 1920 \
                                                            --height 1080 \
                                                            --inline > ./dist/index.html

echo "$_NAME cleaning"
rm -f ./dist/index-source.html

#!/bin/bash
set -e
_NAME="serve locally:"

## make sure you have clean exit for npm run and CI
echo "$_NAME checking script dependencies"
SCRIPTNAME=${0##*/}

NPM=$(command -v npm) || { echo "$_NAME $SCRIPTNAME: npm is not available"; exit 1; }

echo "$_NAME building a project"
${NPM} run build
rm -rf _locally-running/
rm -rf dist/_locally-running/
cp -R dist/ _locally-running/
mv _locally-running dist/_locally-running/

echo "$_NAME serving"
./node_modules/.bin/http-server dist/_locally-running/

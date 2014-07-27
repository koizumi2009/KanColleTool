#!/bin/bash
set -e

VERSION=$(<VERSION)

[[ -d dist/kancolletool-$VERSION ]] && rm -rf dist/kancolletool-$VERSION
mkdir -p dist/kancolletool-$VERSION && cd dist/kancolletool-$VERSION

git clone --recursive ../../viewer
git clone --recursive ../../tool
cp ../../CMakeLists.txt .

cd ..
tar -zcf kancolletool-$VERSION.tar.gz kancolletool-$VERSION
rm -rf kancolletool-$VERSION

#!/bin/sh
#
# usage: ./build-all.sh ARCH (aarch64 or x86_64)
#
# This will produce the lfi, lfi-stores, and native toolchains, with
# distributable tarballs in dist/

set -ex

MARCH=$1

rm -rf $1-lfi-tools
mkdir -p $1-lfi-tools
./build-lfi-tools.sh $PWD/$1-lfi-tools $1

export PATH=$PWD/$1-lfi-tools/bin:$PATH

./build-lfi.sh $PWD/$1-lfi-clang $1
LFISTORES=1 ./build-lfi.sh $PWD/$1-lfi-stores-clang $1
./build-native.sh $PWD/$1-native-clang $1

mkdir -p dist

tar czf dist/$1-lfi-clang.tar.gz $1-lfi-clang
tar czf dist/$1-lfi-stores-clang.tar.gz $1-lfi-stores-clang
tar czf dist/$1-native-clang.tar.gz $1-native-clang
tar czf dist/$1-lfi-tools.tar.gz $1-lfi-tools

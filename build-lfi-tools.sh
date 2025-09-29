#!/bin/sh

set -ex

PREFIX=$1
MARCH=$2

cd lfi-runtime
rm -rf build
meson setup build --cross-file toolchains/$MARCH-linux-clang.meson --libdir=lib --prefix=$PREFIX -Dstatic_lfi_run=true
cd build
ninja install
cd ../..

cd lfi-verifier
rm -rf build
meson setup build --libdir=lib --prefix=$PREFIX
cd build
ninja install
cd ../..

cd lfi-bind
go build -o $PREFIX/bin
cd ..

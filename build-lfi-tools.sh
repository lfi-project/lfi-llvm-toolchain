#!/bin/sh

set -ex

PREFIX=$1
MARCH=$2

cd lfi-runtime
meson setup build --cross-file toolchains/$MARCH-linux-clang.meson --libdir=lib --prefix=$PREFIX
cd build
ninja install
cd ../..

cd lfi-verifier
meson setup build --libdir=lib --prefix=$PREFIX
cd build
ninja install
cd ../..

cd lfi-rewriter
meson setup build --libdir=lib --prefix=$PREFIX
cd build
ninja install
cd ../..

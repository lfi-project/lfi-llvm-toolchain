#!/bin/sh
#
# Usage: build-mimalloc.sh PREFIX

set -ex

PREFIX=$1

mkdir -p $PREFIX/sysroot/usr/bin

cd boxrt
$PREFIX/bin/clang -c -fPIC boxrt.c -o boxrt.o -O2
$PREFIX/bin/clang boxrt.c -o $PREFIX/sysroot/usr/lib/boxrt.lfi -O2 -Wl,--export-dynamic
$PREFIX/bin/llvm-ar rcs $PREFIX/sysroot/usr/lib/libboxrt.a boxrt.o

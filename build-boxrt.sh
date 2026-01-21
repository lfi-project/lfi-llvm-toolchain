#!/bin/sh
#
# Usage: build-boxrt.sh PREFIX

set -ex

PREFIX=$1

mkdir -p $PREFIX/sysroot/usr/bin

cd boxrt
$PREFIX/bin/clang -c -fPIC boxrt.c -o boxrt.o -O2
$PREFIX/bin/clang -c -fPIC boxrt_minimal.c -o boxrt_minimal.o -O2
$PREFIX/bin/clang boxrt.c -o $PREFIX/sysroot/usr/lib/boxrt.lfi -O2 -Wl,--export-dynamic
$PREFIX/bin/clang boxrt_minimal.c -o $PREFIX/sysroot/usr/lib/boxrt_minimal.lfi -O2 -Wl,--export-dynamic
$PREFIX/bin/llvm-ar rcs $PREFIX/sysroot/usr/lib/libboxrt.a boxrt.o
$PREFIX/bin/llvm-ar rcs $PREFIX/sysroot/usr/lib/libboxrt_minimal.a boxrt_minimal.o
$PREFIX/bin/clang boxrt_callbacks.S -o $PREFIX/sysroot/usr/lib/boxrt_callbacks.so -shared -fuse-ld=lld
$PREFIX/bin/llvm-objcopy -O binary --only-section=.text $PREFIX/sysroot/usr/lib/boxrt_callbacks.so $PREFIX/sysroot/usr/lib/boxrt_callbacks.bin

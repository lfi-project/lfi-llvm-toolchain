#!/bin/sh
#
# Usage: build-lfi.sh PREFIX ARCH (aarch64 or x86_64 or riscv64)

set -ex

PREFIX=$1

export MARCH=$2

if [ "$LFISTORES" -eq 1 ]; then
    export ARCH=$2-lfi_stores
elif [ "$LFIJUMPS" -eq 1 ]; then
    export ARCH=$2-lfi_jumps
else
    export ARCH=$2-lfi
fi

./build-llvm.sh $PREFIX
./build-compiler-rt.sh $PREFIX
./build-musl.sh $PREFIX
./build-libcxx.sh $PREFIX
./build-mimalloc.sh $PREFIX
./build-boxrt.sh $PREFIX
./build-sanitizers.sh $PREFIX

cp $(which lfi-rewrite) $PREFIX/lfi-bin
cp $(which lfi-postlink) $PREFIX/lfi-bin
cp $(which lfi-verify) $PREFIX/lfi-bin
cp $(which lfi-run) $PREFIX/lfi-bin

#!/bin/sh
#
# Usage: build-lfi.sh PREFIX ARCH (aarch64 or x86_64 or riscv64)

set -ex

PREFIX=$1

export MARCH=$2
export ARCH=$2_lfi

./build-llvm.sh $PREFIX
./build-compiler-rt.sh $PREFIX
./build-musl.sh $PREFIX
./build-sanitizers.sh $PREFIX # to provide safestack rtlib to libcxx
./build-libcxx.sh $PREFIX
./build-mimalloc.sh $PREFIX
./build-boxrt.sh $PREFIX
./build-sanitizers.sh $PREFIX

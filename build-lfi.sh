#!/bin/sh
#
# Usage: build-lfi.sh [--cfg=CONFIG] PREFIX ARCH (aarch64 or x86_64 or riscv64)
#
# CONFIG selects the clang.cfg/clang++.cfg files from cfg/CONFIG that are
# installed into PREFIX/bin (e.g. lfi/rw, lfi/wo, lfi/jo). Default: lfi/rw.

set -ex

CFG=lfi/rw

while [ $# -gt 0 ]; do
    case "$1" in
    --cfg=*)
        CFG=${1#--cfg=}
        shift
        ;;
    *)
        break
        ;;
    esac
done

if [ ! -f "cfg/$CFG/clang.cfg" ] || [ ! -f "cfg/$CFG/clang++.cfg" ]; then
    echo "no such config: cfg/$CFG" >&2
    exit 1
fi

PREFIX=$1

export MARCH=$2
export ARCH=$2_lfi

./build-llvm.sh $PREFIX

# Install the config before the runtime libraries so they are built with it.
cp "cfg/$CFG/clang.cfg" "cfg/$CFG/clang++.cfg" $PREFIX/bin

./build-compiler-rt.sh $PREFIX
./build-musl.sh $PREFIX
./build-libcxx.sh $PREFIX
./build-mimalloc.sh $PREFIX
./build-boxrt.sh $PREFIX

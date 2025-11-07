#!/bin/sh

./build-lfi.sh $PWD/x86_64-lfi-clang x86_64
LFI_FLAGS="--sandbox=stores" ./build-lfi.sh $PWD/x86_64-lfi-stores-clang x86_64
LFI_FLAGS="--p2size=0" ./build-lfi.sh $PWD/x86_64-lfi-large-clang x86_64
LFI_FLAGS="--p2size=0 --sandbox=stores" ./build-lfi.sh $PWD/x86_64-lfi-large-stores-clang x86_64

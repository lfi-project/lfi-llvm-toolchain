#!/bin/sh

if [ ! -d llvm-project ]; then
    git clone https://github.com/lfi-project/llvm-project --depth 1 -b lfi-patchset/aarch64-pr-3-full
fi

if [ ! -d musl ]; then
    git clone https://github.com/zyedidia/musl -b lfi-1.2.5
fi

if [ ! -d linux ]; then
    git clone https://github.com/torvalds/linux --depth 1 -b v6.12
fi

if [ ! -d mimalloc ]; then
    git clone https://github.com/microsoft/mimalloc -b v3.0.1
fi

#!/bin/sh

if [ ! -d llvm-project ]; then
    git clone https://github.com/lfi-project/llvm-project --depth 1 -b x86-safestack
fi

if [ ! -d musl ]; then
    git clone https://github.com/t-noh/musl -b x86-safestack
fi

if [ ! -d linux ]; then
    git clone https://github.com/torvalds/linux --depth 1 -b v6.12
fi

if [ ! -d mimalloc ]; then
    git clone https://github.com/microsoft/mimalloc -b v3.0.1
fi

if [ ! -d lfi-runtime ]; then
    git clone https://github.com/lfi-project/lfi-runtime -b x86-safestack
fi

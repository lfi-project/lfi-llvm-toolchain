#!/bin/sh

if [ ! -d lfi-runtime ]; then
    git clone https://github.com/lfi-project/lfi-runtime
fi

if [ ! -d lfi-rewriter ]; then
    git clone https://github.com/lfi-project/lfi-rewriter
fi

if [ ! -d lfi-verifier ]; then
    git clone https://github.com/lfi-project/lfi-verifier
fi

if [ ! -d lfi-bind ]; then
    git clone https://github.com/lfi-project/lfi-bind
fi

if [ ! -d llvm-project ]; then
    git clone https://github.com/lfi-project/llvm-project --depth 1 -b lfi-external-20.1.7-safestack
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

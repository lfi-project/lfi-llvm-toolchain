#!/bin/sh
#
# Usage: build-sanitizers.sh PREFIX

set -ex

LLVM_MAJOR=20

PREFIX=$1

# Rebuild compiler-rt with sanitizers now that libcxx has been built. Note: we
# have disabled GWP_ASAN because it uses execinfo.h, which is not available
# from Musl.
rm -rf build-compiler-rt-$ARCH
mkdir -p build-compiler-rt-$ARCH
cd build-compiler-rt-$ARCH
cmake -G Ninja ../llvm-project/compiler-rt \
    -DCMAKE_C_COMPILER=$PREFIX/bin/clang \
    -DCMAKE_CXX_COMPILER=$PREFIX/bin/clang++ \
    -DCMAKE_NM=$PREFIX/bin/llvm-nm \
    -DCMAKE_RANLIB=$PREFIX/bin/llvm-ranlib \
    -DCMAKE_AR=$PREFIX/bin/llvm-ar \
    -DLLVM_TARGET_TRIPLE="$ARCH-linux-musl" \
    -DCMAKE_C_COMPILER_TARGET="$ARCH-linux-musl" \
    -DCMAKE_ASM_COMPILER_TARGET="$ARCH-linux-musl" \
    -DCOMPILER_RT_BUILD_BUILTINS=ON \
    -DCOMPILER_RT_BUILD_LIBFUZZER=OFF \
    -DCOMPILER_RT_BUILD_MEMPROF=OFF \
    -DCOMPILER_RT_BUILD_PROFILE=OFF \
    -DCOMPILER_RT_BUILD_SANITIZERS=ON \
    -DCOMPILER_RT_BUILD_XRAY=OFF \
    -DCOMPILER_RT_BUILD_ORC=OFF \
    -DCOMPILER_RT_BUILD_CTX_PROFILE=OFF \
    -DCOMPILER_RT_USE_BUILTINS_LIBRARY=ON \
    -DCOMPILER_RT_BUILD_GWP_ASAN=OFF \
    -DCMAKE_C_COMPILER_WORKS=ON \
    -DCOMPILER_RT_DEFAULT_TARGET_ONLY=ON \
    -DCMAKE_CXX_COMPILER_WORKS=ON \
    -DCMAKE_INSTALL_PREFIX=$PREFIX/lib/clang/$LLVM_MAJOR
ninja
ninja install

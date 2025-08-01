# Download sources

```
./download.sh
```

Install dependencies (Ubuntu):

```
sudo apt install meson ninja-build build-essential git ccache clang lld llvm cmake golang-go rsync
```

Build the LFI tools (rewriter, verifier, runtime):

```
./build-lfi-tools.sh $PWD/lfi-tools aarch64 # (or x86_64)
```

Put `$PWD/lfi-tools/bin` on your `PATH` before advancing to the next step. In
particular, the `lfi-rewrite` and `lfi-postlink` tools must be available.

# Build LLVM Toolchain

First make sure `ccache` is installed, it will make your build *much* faster if
you end up needing to rebuild.

The builder will first compile LLVM, followed by the target runtime libraries:
`compiler-rt`, `musl-libc`, `libc++`, `libc++abi`, and `libunwind`.

Build LFI toolchain

```
./build-lfi.sh $PWD/aarch64-lfi-clang aarch64
```

Build native toolchain (for comparison)

```
./build-native.sh $PWD/aarch64-native-clang aarch64
```

Build LFI toolchain with only sandboxing for stores:

```
LFISTORES=1 ./build-lfi.sh $PWD/aarch64-lfi-stores-clang aarch64
```

Build LFI toolchain with only sandboxing for jumps (for use in conjunction with
protection keys like Intel MPK):

```
LFIJUMPS=1 ./build-lfi.sh $PWD/aarch64-lfi-jumps-clang aarch64
```

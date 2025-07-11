# Build LFI tools

You will need to install the LFI rewriter tool, called `lfi-rewrite` and the post-linker called `lfi-postlink`.

```
git clone https://github.com/lfi-project/lfi-rewriter
cd lfi-rewriter
meson setup build
cd build
ninja
ninja install
```

Make sure that these tools get installed somewhere on your `PATH`. When
configuring meson you can optionally use `meson setup build --prefix=...` to
give a custom prefix, or you can manually move `lfi-rewrite/lfi-rewrite` to
your destination of choice after running `ninja`.

# Build LLVM Toolchain

First make sure `ccache` is installed, it will make your build *much* faster,
since the build requires compiling LLVM twice (the second time is faster thanks
to `ccache`).

The builder will first compile LLVM, followed by the target runtime libraries:
`compiler-rt`, `musl-libc`, `libc++`, `libc++abi`, and `libunwind`.

Download the sources

```
./download.sh
```

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

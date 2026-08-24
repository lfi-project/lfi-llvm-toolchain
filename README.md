# LFI LLVM Toolchain

This is the LFI toolchain builder. It will build by default from upstream LLVM,
which contains in-development support for LFI.

Current status: `aarch64_lfi` generates programs that can run within the LFI
runtime (syscalls and TP accesses rewritten), but does not have rewrites for
sandboxing control flow or memory accesses.

# Download sources

```
./download.sh
```

Install dependencies (Ubuntu):

```
sudo apt install meson ninja-build build-essential git ccache clang lld llvm cmake golang-go rsync
```

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

# Configurations

The `cfg` directory contains configurations: `clang.cfg`/`clang++.cfg`
[configuration files](https://clang.llvm.org/docs/UsersManual.html#configuration-files)
that are installed into the toolchain's `bin` directory so that Clang applies
them by default. The configuration is installed before the runtime libraries
are built, so it applies to them as well.

Select a configuration with `--cfg` (the default is `lfi/rw` for
`build-lfi.sh` and `native` for `build-native.sh`):

```
./build-lfi.sh --cfg=lfi/wo $PWD/aarch64-lfi-clang aarch64
```

Available LFI configurations:

* `lfi/rw` (default): sandbox reads and writes
* `lfi/wo`: sandbox writes only
* `lfi/jo`: sandbox jumps only (reads and writes are not sandboxed)

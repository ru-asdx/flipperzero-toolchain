#!/bin/bash

set -euo pipefail;

MAC_X86_64_CONFIGURE_ROOT=/toolchain/mac-x86_64-configure-root
MAC_ARM64_CONFIGURE_ROOT=/toolchain/mac-arm64-configure-root
MAC_X86_64_BUILD_ROOT=/toolchain/mac-x86_64-build-root
MAC_ARM64_BUILD_ROOT=/toolchain/mac-arm64-build-root
MAC_X86_64_OUTPUT_ROOT=/toolchain/mac-x86_64-output-root
MAC_ARM64_OUTPUT_ROOT=/toolchain/mac-arm64-output-root

MAC_X86_64_FLAGS="-mmacosx-version-min=11.3 -arch x86_64"
MAC_ARM64_FLAGS="-mmacosx-version-min=11.3 -arch arm64"

CPUS="$(sysctl -n hw.ncpu)";

function build_binutils_x86_64() {
    mkdir -p "$MAC_X86_64_CONFIGURE_ROOT/binutils";
    pushd "$MAC_X86_64_CONFIGURE_ROOT/binutils";
    CPPFLAGS="$MAC_X86_64_FLAGS" \
        CFLAGS="$MAC_X86_64_FLAGS" \
        LDFLAGS="$MAC_X86_64_FLAGS" \
        DYLD_LIBRARY_PATH="$MAC_X86_64_OUTPUT_ROOT/lib" \
        /toolchain/src/src/binutils-gdb/configure \
            --enable-initfini-array \
            --disable-nls \
            --without-x \
            --disable-gdbtk \
            --without-tcl \
            --without-tk \
            --enable-plugins \
            --disable-gdb \
            --without-gdb \
            --target=arm-none-eabi \
            --prefix="$MAC_X86_64_OUTPUT_ROOT" \
            --with-sysroot="$MAC_X86_64_OUTPUT_ROOT/arm-none-eabi" \
            CPPFLAGS="$MAC_X86_64_FLAGS" \
            CFLAGS="$MAC_X86_64_FLAGS" \
            LDFLAGS="$MAC_X86_64_FLAGS" \
            --host=x86_64-apple-darwin \
            --build=x86_64-apple-darwin \
            CC=clang;
    CPPFLAGS="$MAC_X86_64_FLAGS" \
        CFLAGS="$MAC_X86_64_FLAGS" \
        LDFLAGS="$MAC_X86_64_FLAGS" \
        DYLD_LIBRARY_PATH="$MAC_X86_64_OUTPUT_ROOT/lib" \
        make "-j$CPUS";
    make install;
    popd;
}

function build_binutils_arm64() {
    mkdir -p "$MAC_ARM64_CONFIGURE_ROOT/binutils";
    pushd "$MAC_ARM64_CONFIGURE_ROOT/binutils";
    CPPFLAGS="$MAC_ARM64_FLAGS" \
        CFLAGS="$MAC_ARM64_FLAGS" \
        LDFLAGS="$MAC_ARM64_FLAGS" \
        DYLD_LIBRARY_PATH="$MAC_ARM64_OUTPUT_ROOT/lib" \
        /toolchain/src/src/binutils-gdb/configure \
            --enable-initfini-array \
            --disable-nls \
            --without-x \
            --disable-gdbtk \
            --without-tcl \
            --without-tk \
            --enable-plugins \
            --disable-gdb \
            --without-gdb \
            --target=arm-none-eabi \
            --prefix="$MAC_ARM64_OUTPUT_ROOT" \
            --with-sysroot="$MAC_ARM64_OUTPUT_ROOT/arm-none-eabi" \
            CPPFLAGS="$MAC_ARM64_FLAGS" \
            CFLAGS="$MAC_ARM64_FLAGS" \
            LDFLAGS="$MAC_ARM64_FLAGS" \
            --host=aarch64-apple-darwin \
            --build=aarch64-apple-darwin \
            CC=clang;
    CPPFLAGS="$MAC_ARM64_FLAGS" \
        CFLAGS="$MAC_ARM64_FLAGS" \
        LDFLAGS="$MAC_ARM64_FLAGS" \
        DYLD_LIBRARY_PATH="$MAC_ARM64_OUTPUT_ROOT/lib" \
        make "-j$CPUS";
    make install;
    popd;
}

build_binutils_x86_64;
build_binutils_arm64;

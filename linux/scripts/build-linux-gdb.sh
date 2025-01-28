#!/bin/bash

set -euo pipefail;

. /toolchain/src/buildvars.sh

function build_linux_gdb() {
    rm -rf "$LINUX_CONFIGURE_ROOT/gdb";
    mkdir -p "$LINUX_CONFIGURE_ROOT/gdb";
    pushd "$LINUX_CONFIGURE_ROOT/gdb";
    LDFLAGS="-L$LINUX_BUILD_ROOT/lib -L$LINUX_OUTPUT_ROOT/lib" CPPFLAGS="-I$LINUX_BUILD_ROOT/include -I$LINUX_OUTPUT_ROOT/include -I$LINUX_OUTPUT_ROOT/include/readline" LD_LIBRARY_PATH="LINUX_OUTPUT_ROOT/lib" "/toolchain/src/src/gdb/configure" \
        --enable-initfini-array \
        --enable-tui \
        --disable-nls \
        --without-x \
        --disable-gdbtk \
        --without-tcl \
        --without-tk \
        --without-libunwind-ia64 \
        --without-lzma \
        --without-babeltrace \
        --without-intel-pt \
        --without-xxhash \
        --without-debuginfod \
        --without-guile \
        --disable-source-highlight \
        --disable-objc-gc \
        --with-expat \
        "--with-libexpat-prefix=$LINUX_BUILD_ROOT" \
        --with-libexpat-type=static \
        --disable-binutils \
        --disable-sim \
        --disable-as \
        --disable-ld \
        --enable-plugins \
        --target=arm-none-eabi \
        "--prefix=$LINUX_OUTPUT_ROOT" \
        "--with-libmpfr-prefix=$LINUX_BUILD_ROOT" \
        --with-libmpfr-type=static \
        "--with-mpfr=$LINUX_BUILD_ROOT" \
        "--with-libgmp-prefix=$LINUX_BUILD_ROOT" \
        --with-libgmp-type=static \
        "--with-gmp=$LINUX_BUILD_ROOT" \
        "--with-curses=$LINUX_OUTPUT_ROOT" \
        LDFLAGS="-L$LINUX_BUILD_ROOT/lib -L$LINUX_OUTPUT_ROOT/lib" \
        CPPFLAGS="-I$LINUX_BUILD_ROOT/include -I$LINUX_OUTPUT_ROOT/include -I$LINUX_OUTPUT_ROOT/include/readline";
    LDFLAGS="-L$LINUX_BUILD_ROOT/lib -L$LINUX_OUTPUT_ROOT/lib" CPPFLAGS="-I$LINUX_BUILD_ROOT/include -I$LINUX_OUTPUT_ROOT/include -I$LINUX_OUTPUT_ROOT/include/readline" LD_LIBRARY_PATH="LINUX_OUTPUT_ROOT/lib" make "-j$CPUS";
    LDFLAGS="-L$LINUX_BUILD_ROOT/lib -L$LINUX_OUTPUT_ROOT/lib" CPPFLAGS="-I$LINUX_BUILD_ROOT/include -I$LINUX_OUTPUT_ROOT/include -I$LINUX_OUTPUT_ROOT/include/readline" LD_LIBRARY_PATH="LINUX_OUTPUT_ROOT/lib" make install;
    popd;
}

function build_linux_gdb_py() {
    rm -rf "$LINUX_CONFIGURE_ROOT/gdb-py";
    mkdir -p "$LINUX_CONFIGURE_ROOT/gdb-py";
    pushd "$LINUX_CONFIGURE_ROOT/gdb-py";
    LDFLAGS="-L$LINUX_BUILD_ROOT/lib -L$LINUX_OUTPUT_ROOT/lib" CPPFLAGS="-I$LINUX_BUILD_ROOT/include -I$LINUX_OUTPUT_ROOT/include -I$LINUX_OUTPUT_ROOT/include/readline" LD_LIBRARY_PATH="LINUX_OUTPUT_ROOT/lib" "/toolchain/src/src/gdb/configure" \
        --enable-initfini-array \
        --enable-tui \
        --disable-nls \
        --without-x \
        --disable-gdbtk \
        --without-tcl \
        --without-tk \
        --without-libunwind-ia64 \
        --without-lzma \
        --without-babeltrace \
        --without-intel-pt \
        --without-xxhash \
        --without-debuginfod \
        --without-guile \
        --disable-source-highlight \
        --disable-objc-gc \
        --with-expat \
        "--with-libexpat-prefix=$LINUX_BUILD_ROOT" \
        --with-libexpat-type=static \
        --disable-binutils \
        --disable-sim \
        --disable-as \
        --disable-ld \
        --enable-plugins \
        --target=arm-none-eabi \
        "--prefix=$LINUX_OUTPUT_ROOT" \
        "--with-libmpfr-prefix=$LINUX_BUILD_ROOT" \
        --with-libmpfr-type=static \
        "--with-mpfr=$LINUX_BUILD_ROOT" \
        "--with-libgmp-prefix=$LINUX_BUILD_ROOT" \
        --with-libgmp-type=static \
        "--with-gmp=$LINUX_BUILD_ROOT" \
        "--with-python=$LINUX_OUTPUT_ROOT/bin/python3" \
        "--program-prefix=arm-none-eabi-" \
        "--program-suffix=-py3" \
        "--with-curses=$LINUX_OUTPUT_ROOT" \
        LDFLAGS="-L$LINUX_BUILD_ROOT/lib -L$LINUX_OUTPUT_ROOT/lib" \
        CPPFLAGS="-I$LINUX_BUILD_ROOT/include -I$LINUX_OUTPUT_ROOT/include -I$LINUX_OUTPUT_ROOT/include/readline";
    LDFLAGS="-L$LINUX_BUILD_ROOT/lib -L$LINUX_OUTPUT_ROOT/lib" CPPFLAGS="-I$LINUX_BUILD_ROOT/include -I$LINUX_OUTPUT_ROOT/include -I$LINUX_OUTPUT_ROOT/include/readline" LD_LIBRARY_PATH="LINUX_OUTPUT_ROOT/lib" make "-j$CPUS";
    LDFLAGS="-L$LINUX_BUILD_ROOT/lib -L$LINUX_OUTPUT_ROOT/lib" CPPFLAGS="-I$LINUX_BUILD_ROOT/include -I$LINUX_OUTPUT_ROOT/include -I$LINUX_OUTPUT_ROOT/include/readline" LD_LIBRARY_PATH="LINUX_OUTPUT_ROOT/lib" make install;
    popd;
}

#build_linux_gdb
build_linux_gdb_py
cleanup_relink "$LINUX_OUTPUT_ROOT"

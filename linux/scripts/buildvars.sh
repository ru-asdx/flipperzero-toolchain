#!/bin/bash


function cleanup_relink() {
    local DIRECTORY;
    DIRECTORY="$1";
    find "$DIRECTORY" \
        -type f \
        \( -name "*.a" -or -name "*.la" \) \
        -delete;
    rm -rf "$DIRECTORY/share/man"
    relink.sh "$DIRECTORY";
}

die() {
    echo "[!] $*" >&2
    exit 1
}


LINUX_BUILD_ROOT=/toolchain/linux-build-root
LINUX_OUTPUT_ROOT=/toolchain/linux-output-root
LINUX_CONFIGURE_ROOT=/toolchain/linux-configure-root

CMD=${1:-}

CPUS=$(($(nproc) + 1))
ARCH_BUILD=$(uname -m | sed 'y/XI/xi/')

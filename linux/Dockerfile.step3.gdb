##
## flipperzero-toolchain-linux-gdb
##
FROM flipperzero-toolchain-linux-python AS flipperzero-toolchain-linux-gdb
ADD scripts/build-linux-gdb.sh /toolchain/src/

RUN /toolchain/src/build-linux-gdb.sh

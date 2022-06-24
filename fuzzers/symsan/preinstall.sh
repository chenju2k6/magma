#!/bin/bash
set -e

apt-get update && \
    apt-get install -y make build-essential clang llvm-dev git wget cmake subversion \
        ninja-build python-pip zlib1g-dev rustc cargo inotify-tools
apt-get -y install libc++-dev libc++abi-dev

rm -rf /usr/local/include/llvm && rm -rf /usr/local/include/llvm-c
rm -rf /usr/include/llvm && rm -rf /usr/include/llvm-c
ln -s /usr/lib/llvm-6.0/include/llvm /usr/include/llvm
ln -s /usr/lib/llvm-6.0/include/llvm-c /usr/include/llvm-c


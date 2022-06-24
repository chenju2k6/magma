#!/bin/bash
set -e

##
# Pre-requirements:
# - env FUZZER: path to fuzzer work dir
# - env TARGET: path to target work dir
# - env MAGMA: path to Magma support files
# - env OUT: path to directory where artifacts are stored
# - env CFLAGS and CXXFLAGS must be set to link against Magma instrumentation
##

export LIBS="$LIBS -l:afl_driver.o -lstdc++"

(
    export CC="$FUZZER/afl/afl-clang-fast"
    export CXX="$FUZZER/afl/afl-clang-fast++"

    export OUT="$OUT/afl"
    export LDFLAGS="$LDFLAGS -L$OUT"

    "$MAGMA/build.sh"
    "$TARGET/build.sh"
)

(
    export CC="$FUZZER/symsan/bin/ko-clang"
    export CXX="$FUZZER/symsan/bin/ko-clang++"

    export OUT="$OUT/symsantrack"
    export LDFLAGS="$LDFLAGS -L$OUT"

    export USE_TRACK=1

    "$MAGMA/build.sh"
    "$TARGET/build.sh"
)

(
    export CC="$FUZZER/symsan/bin/ko-clang"
    export CXX="$FUZZER/symsan/bin/ko-clang++"

    export OUT="$OUT/symsanfast"
    export LDFLAGS="$LDFLAGS -L$OUT"


    "$MAGMA/build.sh"
    "$TARGET/build.sh"
)

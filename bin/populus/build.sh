#!/bin/bash
# -ex
set -x
set -e

# SRCDIR=~/src/PopulusSC
SRCDIR=`pwd`
BINDIR=~/src/build/bin
COVDIR=~/src/build/coverage
COV_TMP_DIR=~/src/build/coverity
COV_ROOT=/opt/cov-analysis
COV_BIN_DIR=$COV_ROOT/bin
COV_CONF_DIR=$COV_ROOT/config
DK_LINUX=/opt/DK/x64_linux
LCOV_COBERTURA=$DK_LINUX/tools/lcov-to-cobertura-xml/lcov_cobertura/lcov_cobertura.py
GCOVR=$DK_LINUX/tools/gcovr/scripts/gcovr
LCOV=lcov
GENHTML=genhtml
ME=`basename $0`

set +e
PACKAGES=
which genhtml > /dev/null
if [[ $? -ne 0 ]]; then
    PACKAGES="$PACKAGES lcov"
fi
if [[ "$PACKAGES" != "" ]]; then
    echo You have to install additional utils by typing:
    echo sudo apt install $PACKAGES
    exit 1
fi
set -e

function print_help() {
    echo "Building PopulusSC"
    echo
    echo "usage: $ME options..."
    echo "parameters:"
    echo "  -c          [re]generate make file with cmake in debug mode."
    echo "  -C          [re]generate make file with cmake in release mode."
    echo "  -b          [re]building with gcc."
    echo "  -t          run tests."
    echo "  -g          prepare coverage with gcovr."
    echo "  -l          prepare coverage with lcov."
    echo "  -s          prepare coverity results in debug mode."
    echo "  -S          prepare coverity results in release mode."
    echo "  -h          help."
    echo
}

function exec_cmake_release() {
    rm -rf $BINDIR || true
    mkdir -p $BINDIR
    cd $BINDIR
    cmake -DCMAKE_BUILD_TYPE=Release -DCOVERAGE=ON -DUNIT_TESTS=ON $SRCDIR
}

function exec_cmake_debug() {
    rm -rf $BINDIR || true
    mkdir -p $BINDIR
    cd $BINDIR
    cmake -DCMAKE_BUILD_TYPE=Debug -DCOVERAGE=ON -DUNIT_TESTS=ON $SRCDIR
}

function exec_gcc() {
    cd $BINDIR
    make -j 2
}

function exec_tests() {
    cd $BINDIR
    ctest --output-on-failure
}

function exec_gcovr() {
    pushd $SRCDIR 1>/dev/null
    rm -rf $COVDIR/gcovr || true
    mkdir -p $COVDIR/gcovr/html
    $GCOVR --object-directory=$BINDIR --html --exclude-unreachable-branches --html-details -o $COVDIR/gcovr/html/coverage.html -e '3rdparty'
    $GCOVR --object-directory=$BINDIR --xml --exclude-unreachable-branches --xml-pretty -o $COVDIR/gcovr/coverage.xml #  -e '(usr.include|3rdparty)'
    firefox $COVDIR/gcovr/html/coverage.html 2>/dev/null &
    popd 1>/dev/null
}

function exec_lcov() {
    #cd $BINDIR
    rm -rf $COVDIR/lcov || true
    mkdir -p $COVDIR/lcov

    $LCOV --capture --directory $BINDIR --output-file $COVDIR/lcov/coverage.info --rc lcov_branch_coverage=1
    $LCOV -r $COVDIR/lcov/coverage.info "/usr/include/*" --output-file $COVDIR/lcov/coverage.info --rc lcov_branch_coverage=1
    $LCOV -r $COVDIR/lcov/coverage.info "*/3rdparty/*" --output-file $COVDIR/lcov/coverage.info --rc lcov_branch_coverage=1
    #$LCOV -r $COVDIR/lcov/coverage.info "*/test/*" --output-file $COVDIR/lcov/coverage.info --rc lcov_branch_coverage=1
    $LCOV_COBERTURA $COVDIR/lcov/coverage.info -b $BINDIR -o $COVDIR/lcov/coverage.xml -d
    $GENHTML $COVDIR/lcov/coverage.info --output-directory $COVDIR/lcov/html --rc lcov_branch_coverage=1 --demangle-cpp
    firefox $COVDIR/lcov/html/index.html &
}

function exec_coverity_debug() {
    exec_cmake_debug;

    cd $BINDIR
    rm -rf $COV_TMP_DIR || true
    mkdir -p $COV_TMP_DIR

    # $COV_BIN_DIR/cov-configure --compiler /usr/bin/c++ --comptype gcc

    $COV_BIN_DIR/cov-build --dir $COV_TMP_DIR make -j 2
    $COV_BIN_DIR/cov-analyze --dir $COV_TMP_DIR --misra-config $COV_CONF_DIR/MISRA/MISRA_cpp2008_7.config -j auto # --disable-default # --strip-path "$SRCDIR"
    $COV_BIN_DIR/cov-format-errors --dir $COV_TMP_DIR --filesort --strip-path "$SRCDIR" -x --html-output $COV_TMP_DIR/html --exclude-files '/(3rdparty|test|usr)/'
    firefox $COV_TMP_DIR/html/index.html & >/dev/null
}

function exec_coverity_release() {
    exec_cmake_release;

    cd $BINDIR
    rm -rf $COV_TMP_DIR || true
    mkdir -p $COV_TMP_DIR

    # $COV_BIN_DIR/cov-configure --compiler /usr/bin/c++ --comptype gcc

    $COV_BIN_DIR/cov-build --dir $COV_TMP_DIR make -j 2
    $COV_BIN_DIR/cov-analyze --dir $COV_TMP_DIR --misra-config $COV_CONF_DIR/MISRA/MISRA_cpp2008_7.config -j 2 --strip-path "$SRCDIR" --disable-default
    $COV_BIN_DIR/cov-format-errors --dir $COV_TMP_DIR --filesort --strip-path "$SRCDIR" -x --html-output $COV_TMP_DIR/html --exclude-files '/(3rdparty|test|usr)/'
    firefox $COV_TMP_DIR/html/index.html &
}

if [ $# = 0 ]; then
    exec_cmake_release
    exec_gcc
    exec_tests
    exec_gcovr
    # exec_lcov
fi

while getopts ":cCbtglsSh" opt ;
do
    case $opt in
        c) exec_cmake_debug;
            ;;
        C) exec_cmake_release;
            ;;
        b) exec_gcc;
            ;;
        t) exec_tests;
            ;;
        g) exec_gcovr;
            ;;
        l) exec_lcov;
            ;;
        s) exec_coverity_debug;
            ;;
        S) exec_coverity_debug;
            ;;
        h) print_help;
            ;;
        *) echo "Incorrect parameter.";
            echo "For help call $ME -h";
            exit 1
            ;;
        esac
done


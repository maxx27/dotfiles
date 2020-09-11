#!/bin/bash -ex
# git bisect start HEAD HEAD~100 --   # culprit is among the last 100
# git bisect run ~/find_reg.sh
# git bisect reset                   # quit the bisect session

# Are there any changes
#if [git diff --quiet]

git submodule update --init --recursive
rm -rf build || true
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release -DPOPULUS_3D:BOOL=ON -DLUA:BOOL=OFF -DHOSTNAME=docker_ubuntu12_x64_rel ../PopulusEngine || exit 125
make -j 4 unit_test_DisplayCanvasTest || exit 125
# starting x server
xLog=xvfb.log; xDisplay=:0; export DISPLAY=$xDisplay
xPid=$(trap : USR1; (trap '' USR1; exec Xvfb $xDisplay -nolisten tcp -screen 0 1280x1024x24 >$xLog 2>&1) & wait || :; echo $!)
# Paste here commands those use X
ctest -R DisplayCanvasTest
# stopping x server
rm $xLog || true
kill $xPid || true
test -f unit_test/output_images/GL_Buffered_Fixed_vbo/test_id19_50ms.png

# 0 if the current source code is good/old, and exit with a code
#        between 1 and 127 (inclusive), except 125, if the current source code is bad/new.

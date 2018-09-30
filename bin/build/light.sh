#!/bin/sh
git clone git@github.com:haikarainen/light.git
cd light
./autogen.sh
./configure
make deb
cd ..
sudo dpkg -i light_1.2_amd64.deb

# xev -event keyboard

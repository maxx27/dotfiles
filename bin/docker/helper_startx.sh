#!/bin/bash
xLog=xvfb.log
xDisplay=:0
export DISPLAY=$xDisplay
xPid=$(trap : USR1; (trap '' USR1; exec Xvfb $xDisplay -nolisten tcp -screen 0 1280x1024x24 >$xLog 2>&1) & wait || :; echo $!)


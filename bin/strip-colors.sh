#!/bin/sh
# https://superuser.com/questions/380772/removing-ansi-color-codes-from-text-stream
sed 's/\x1b\[[0-9;]*m//g'

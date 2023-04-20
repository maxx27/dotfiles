#!/bin/bash
# remove all detached users
# https://superuser.com/questions/358835/force-logout-a-user
for pid in $(
    for ptsn in $(w | grep **user_name** | grep pts | awk '{print $2}'); do
        ps -dN | grep "$ptsn " | awk '{print $1}' ;
    done
    ); do
    kill -9 $pid;
done

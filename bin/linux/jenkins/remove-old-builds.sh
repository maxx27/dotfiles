#!/bin/bash

if [[ "$1" == "" ]] ; then
   DAYS=14
else
   re='^[0-9]+$'
   if ! [[ $1 =~ $re ]] ; then
      echo "error: '$1' is not a number" >&2; exit 1
   fi
   DAYS=$1
fi
#echo "DAYS=$DAYS"

# remove builds older than 14 days
find /var/lib/jenkins/jobs -depth -prune -type d -regextype posix-extended -regex '.*builds/[0-9]+' -regex '^.*(Populus_Release|501_Installer_Windows7_x86).*$' -mtime +$DAYS -exec rm -rf '{}' \;
#find /var/lib/jenkins/jobs -depth -prune -type d -regextype posix-extended -regex '.*builds/[0-9]+' -mtime +$DAYS -exec rm -rf '{}' \;
#find /var/lib/jenkins/jobs -type d -regextype posix-extended -regex '.*builds/[0-9]+' -mtime +14 -not -regex '.*Release.*' -exec rm -rf '{}' \;

# remove broken lastSuccessfulBuild and similar
find /var/lib/jenkins/jobs -type l -! -exec test -e {} \; -delete


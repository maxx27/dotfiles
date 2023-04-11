#!/bin/bash -ex
# update hook script inside gerrit.war

VERSION=2.15.6

[ ! -e gerrit-$VERSION.war ] && wget https://gerrit-releases.storage.googleapis.com/gerrit-$VERSION.war

[ -e gerrit-$VERSION ] && rm -rf gerrit-$VERSION
mkdir gerrit-$VERSION
pushd gerrit-$VERSION

jar xvf ../gerrit-$VERSION.war WEB-INF/lib/gerrit-server-libserver.jar

# update hook
pushd WEB-INF/lib
mkdir gerrit-server-libserver
cd gerrit-server-libserver
jar xf ../gerrit-server-libserver.jar com/google/gerrit/server/tools/root/hooks/commit-msg
curl --output com/google/gerrit/server/tools/root/hooks/commit-msg http://populus-gerrit.luxoft.com/files/hooks/commit-msg
jar uvf ../gerrit-server-libserver.jar com/google/gerrit/server/tools/root/hooks/commit-msg
cd ..
rm -rf gerrit-server-libserver

popd
jar uvf ../gerrit-2.15.6.war WEB-INF/lib/gerrit-server-libserver.jar
rm -rf WEB-INF
popd

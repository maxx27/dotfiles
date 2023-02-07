@echo off
docker container run --rm -it ^
  -v "%CD%":/work ^
  maxx27/ansible-control %*

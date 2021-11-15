@echo off
docker container run --rm -it ^
  -v "%CD%":/work ^
  dxctraining/ansible-control %*

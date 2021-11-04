@echo off
docker container run --rm ^
  -v "%CD%":/work ^
  dxctraining/ansible-control ansible-galaxy %*

@echo off
docker container run --rm ^
  -v "%CD%":/work ^
  maxx27/ansible-control ansible-playbook %*

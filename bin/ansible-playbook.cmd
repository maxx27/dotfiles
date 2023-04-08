@echo off
docker container run -it --rm ^
  -v "%CD%":/work ^
  maxx27/ansible-control ansible-playbook %*

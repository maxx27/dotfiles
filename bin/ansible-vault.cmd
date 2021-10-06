@echo off
docker container run --rm ^
  -v "%CD%":/work:ro ^
  -v "%USERPROFILE%/.ansible/roles":/root/.ansible/roles ^
  -v "%USERPROFILE%/.ssh:/root/.ssh:ro" ^
  dxctraining/ansible ansible-vault %*

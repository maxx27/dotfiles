@echo off
docker container run --rm ^
  -v "%CD%":/work ^
  dxctraining/ansible-control ansible %*

::  -v "%USERPROFILE%/.ansible/roles":/home/bond/.ansible/roles ^
::  -v "%USERPROFILE%/.ssh:/home/bond/.ssh:ro" ^

:: readonly isn't necessary - some commands may install roles and thus modify files
::  -v "%CD%":/work:ro ^

:: you may change working directory
:: -w /work

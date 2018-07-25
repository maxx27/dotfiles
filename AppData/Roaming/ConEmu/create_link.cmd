:: Call script where do you want to create link to ConEmu.xml
set FILE=ConEmu.xml
if exist %FILE% (
    echo File %FILE% is already exist in current folder. Abort...
    goto :EOF
)
mklink %FILE% %~dp0\%FILE%

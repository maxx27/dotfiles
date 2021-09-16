:: need admin permissions
choco install -y "%USERPROFILE%\bin\packages\choco\choco.config"
:: these packages updated automatically or don't need to be updated
choco pin add -n pycharm-community
choco pin add -n onetastic

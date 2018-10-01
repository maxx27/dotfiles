#!/bin/bash
read -p "Username: " user
read -p "Password: " -s pass
# https://superuser.com/questions/649614/connect-using-anyconnect-from-command-line
printf "$user\n$pass\n\y\nexit\n" | /opt/cisco/anyconnect/bin/vpn -s connect vpn.luxoft.com

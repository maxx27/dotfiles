#!/bin/bash -ex
if [[ $EUID -ne 0 ]]; then
	echo "This script must be run as root" 1>&2
	exit 1
fi
wget http://cert.luxoft.com/Luxoft-Root-CA.crt http://cert.luxoft.com/Luxoft-Issuing-CA-G2.crt
sudo mkdir -p /usr/share/ca-certificates/luxoft
sudo cp Luxoft-Root-CA.crt Luxoft-Issuing-CA-G2.crt /usr/share/ca-certificates/luxoft
sudo dpkg-reconfigure ca-certificates

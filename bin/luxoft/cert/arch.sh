#!/bin/bash -ex
wget http://cert.luxoft.com/Luxoft-Root-CA.crt
wget http://cert.luxoft.com/Luxoft-Issuing-CA.crt
wget http://cert.luxoft.com/Luxoft-Issuing-CA-G2.crt
sudo trust anchor --store *.crt

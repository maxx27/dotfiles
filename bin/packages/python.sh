#!/bin/bash
PACKAGES=pip pep8 neovim flask waitress psutil requests ppretty
for package in $PACKAGES; do
    python -m pip install --upgrade $package
done

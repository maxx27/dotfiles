#!/bin/bash
PACKAGES=$(cat <<EOF | awk '{print $1;}'
    pip         - to update pip itself
    pycodestyle - replacement for pep8
    pyreadline  - to use readline library
    ptpython    - enhancement for python CLI
    ipython     - enhancement for python CLI
    ppretty     - to print pretty structures
    pylint
    pytest
    requests    - web crawling tools
    flask
    waitress    - application server for flask
    psutil
    neovim
EOF
)

for package in $PACKAGES; do
    python -m pip install --upgrade $package
done

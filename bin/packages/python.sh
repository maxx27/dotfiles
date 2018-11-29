#!/bin/bash -ex
PACKAGES=$(cat <<EOF | awk '{print $1;}'
    pip         - to update pip itself
    pycodestyle - replacement for PEP8
    autopep8    - autoformat according to PEP8
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

if which pip3 > /dev/null; then
    # after installing pip, you can face an error:
    # ImportError: cannot import name main
    # Solution: restart shell
    # https://github.com/pypa/pip/issues/5240
    COMMAND='pip3'
elif which python3 > /dev/null; then
    COMMAND='python3 -m pip'
elif which pip > /dev/null; then
    COMMAND='pip'
elif which python > dev/null; then
    COMMAND='python -m pip'
else
    echo "No python found"
    exit 1
fi

for package in $PACKAGES; do
    # sudo -H $COMMAND uninstall $package
    $COMMAND install --user --upgrade $package
done

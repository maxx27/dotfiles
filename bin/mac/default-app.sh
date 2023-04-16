#!/bin/zsh

# To install:
# brew install duti

# To view associations:
# duti -x sh

duti -s com.microsoft.VSCode public.json all
duti -s com.microsoft.VSCode public.plain-text all
duti -s com.microsoft.VSCode public.python-script all
duti -s com.microsoft.VSCode public.shell-script all
duti -s com.microsoft.VSCode public.source-code all
duti -s com.microsoft.VSCode public.text all
duti -s com.microsoft.VSCode public.unix-executable all
# this works for files without a filename extension
duti -s com.microsoft.VSCode public.data all
duti -s com.microsoft.VSCode .md all

#!/usr/bin/python
"""
    Generate a list of installed packages.

    Usage:
        create_config.py [-h] [-o OUTPUT] [-s SKIP [SKIP ...]] [-v]

        optional arguments:
        -h, --help            show this help message and exit
        -o OUTPUT, --output OUTPUT
                              output filename
        -s SKIP [SKIP ...], --skip SKIP [SKIP ...]
                              list of regexp to skip packages
        -v, --verbose         verbose output

    Example of usage:
        python create_config.py -o file.config
"""

import argparse
import logging
import os
import re
import sys

logger = logging.getLogger(__name__)

def main(args):
    global logger

    cmd = 'choco list -lo -r'
    logger.debug('Execute %s', cmd)
    stream = os.popen(cmd)
    output = stream.readlines()
    exitcode = stream.close()
    if exitcode is not None:
        logger.error('choco finished with error %i', exitcode)
        sys.exit(1)

    logger.debug('Write results to %s', args.output)
    f = open(args.output, "w")
    f.write('<?xml version="1.0" encoding="utf-8"?>\n')
    f.write('<packages>\n')
    for line in output:
        package, version = line.strip().split('|')
        skip = False
        for regex in args.skip:
            if re.search(regex, package):
                logger.debug('Package "%s" matches pattern "%s" -> skip', package, regex)
                skip = True
                break
        if not skip:
            f.write('  <package id="{}"/>\n'.format(package))
    f.write('</packages>\n')
    f.close()
    logger.debug('File %s has been created', args.output)


if __name__ == '__main__':
    logging.basicConfig(stream=sys.stderr, level=logging.INFO)

    parser = argparse.ArgumentParser()
    parser.add_argument('-o', '--output', default='packages.config', help='output filename')
    parser.add_argument('-s', '--skip', nargs='+', default=['KB.*', 'chocolatey-*', 'DotNet*'], help='list of regexp to skip packages')
    parser.add_argument('-v', '--verbose', action='store_true', help='verbose output')
    args = parser.parse_args()

    if args.verbose:
        logger.setLevel(logging.DEBUG)

    main(args)

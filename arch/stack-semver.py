#!/usr/bin/env python

import sys
import subprocess
import re

re_build_depends = re.compile(r'( *)build-depends: *')
re_pkgname = r'([A-Za-z][-_A-Za-z0-9]+)'
re_version = re.compile(r'([0-9]+)\.([0-9]+)(.*)')

class CabalFileFound(Exception):
    pass

def parse_cabal(cabal_str):
    build_depends = re_build_depends.search(cabal_str)
    cabal_str = cabal_str[build_depends.end() + 1:]
    build_depends_indent = build_depends.groups()[0]
    one_package = re.compile(build_depends_indent + r' +' + re_pkgname + '.*')
    for _ in range(512):
        matched = one_package.match(cabal_str)
        if matched is None:
            break
        pkg = matched.groups()[0]
        if pkg == 'base':
            continue
        yield pkg
        cabal_str = cabal_str[matched.end() + 1:]

try:
    for line in subprocess.check_output(['ls']).decode('utf-8').split('\n'):
        if line.endswith('.cabal'):
            cabal_file_name = line
            raise CabalFileFound
except CabalFileFound:
    pass
else:
    CabalFileNotFoundBoom

with open(cabal_file_name, 'r') as f:
    cabal_str = f.read()


deps = subprocess.check_output(['stack', 'list-dependencies'])
deps = deps.decode('utf-8')

pkgs = {}

for line in deps.split('\n'):
    if not line.strip():
        continue
    pkg, _, ver = line.partition(' ')
    pkgs[pkg] = re_version.match(ver).groups()

for pkg in parse_cabal(cabal_str):
    ver = pkgs[pkg]
    major = int(ver[0])
    minor = int(ver[1])
    upper = '0.%d' % (minor + 1) if major == 0 else str(major + 1)
    print('%s >= %s && < %s,' % (pkg, ver[0] + '.' + ver[1] + ver[2], upper))

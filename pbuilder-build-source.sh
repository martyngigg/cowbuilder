#!/bin/bash
#
# Takes a the name of the distribution and builds a package
#

if [ ! $# -eq 1 ]; then
    echo "Usage: $0 codename"
    exit 1
fi

if [ ! -f $HOME/.pbuilderrc ]; then
  echo "$HOME/.pbuilderrc does not exist. Please run this script with sudo HOME=\$HOME $0"
  exit 1
fi

DISTRIB=$1
COW_BASE=/var/cache/pbuilder/$DISTRIB-amd64/base.cow

DIST=$DISTRIB pdebuild --debbuildopts "-S" \
    --use-pdebuild-internal --pbuilder \
    cowbuilder -- --basepath=$COW_BASE

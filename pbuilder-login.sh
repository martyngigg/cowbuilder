#!/bin/bash
#
# Takes a the name of the distribution logs in to the pbuilder
# environment at /var/cache/pbuilder/DIST-amd64

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

DIST=$DISTRIB cowbuilder --login --basepath=$COW_BASE \
    --save-after-login
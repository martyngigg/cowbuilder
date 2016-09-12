#!/bin/bash
#
# Takes a the name of the distribution logs in to the pbuilder
# environment at /var/cache/pbuilder/DIST-amd64

if [ ! $# -eq 1 ]; then
    echo "Usage: $0 codename"
    exit 1
fi

if [ ! -f $HOME/.pbuilderrc ]; then
  echo "$HOME/.pbuilderrc does not exist."
  exit 1
fi

DISTRIB=$1
PBUILDERRC=$HOME/.pbuilderrc
COW_BASE=/var/cache/pbuilder/$DISTRIB-amd64/base.cow

sudo DIST=$DISTRIB cowbuilder --configfile $PBUILDERRC --login --basepath=$COW_BASE \
    --save-after-login

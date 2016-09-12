#!/bin/bash
#
# Takes a the name of the distribution and updates the cowbuilder
if [ ! `id -u` = 0 ] ; then
    echo "Please run this script as root"
    exit 1
fi

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

DIST=$DISTRIB cowbuilder --configfile $PBUILDERRC --update --basepath=$COW_BASE

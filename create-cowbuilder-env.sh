#!/bin/bash
#
# Takes a the name of the distribution and creates a new pbuilder
# environment at /var/cache/pbuilder/DIST-amd64
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
COW_BASE_DIR=$(dirname $COW_BASE)
GPG_KEY=/usr/share/keyrings/ubuntu-archive-keyring.gpg

if [ -d $COW_BASE ]; then
    echo "Cowbuilder environment already exists at '$COW_BASE'."
    echo "Remove it and rerun this script"
    exit 1
fi

echo "Setting up new cowbuilder environment in $COW_BASE"

# Do we have the gpg key
if [ ! -f $GPG_KEY  ]; then
    echo "Downloading Ubuntu archive gpg key"
    wget -O /usr/share/keyrings/ubuntu-archive-keyring.gpg http://archive.ubuntu.com/ubuntu/project/ubuntu-archive-keyring.gpg
else
    echo "Ubuntu GPG key already installed."
fi

echo "Creating $COW_BASE_DIR for new environment"
mkdir -p $COW_BASE_DIR
BUILDRESULT=/var/cache/pbuilder/$DISTRIB/result
echo "Creating buildresult dir"
mkdir -p $BUILDRESULT
echo "Running cowbuilder --create"
DIST=$DISTRIB cowbuilder --create --distribution $DISTRIB --components "main universe" \
    --basepath $COW_BASE --debootstrapopts --arch --debootstrapopts amd64 \
    --debootstrapopts --variant=buildd --keyring=$GPG_KEY --configfile=$PBUILDERRC

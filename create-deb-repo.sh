#!/bin/bash
#make a debian package repo of all created packages and offer to serve it on the LAN
#sign the package repository in order to update the github repo

_debian_codename=(sid)
_packagearchitecture="amd64 arm64 armhf armel i386 mips mipsel mips64el ppc64el riscv64 s390x"
_signwith=DE08F924EEE93832DABC642CA8DC761B1C0C0CFC

echo -e "making repo for debian $_debian_codename. Architecture: $_packagearchitecture"

[[ ! -d "conf" ]] && mkdir conf

echo "creating repo configuration file"
echo "Origin: the-skycoin-project" > conf/distributions
echo "Label: the-skycoin-project" >> conf/distributions
echo "Codename: $_debian_codename" >> conf/distributions
echo "Architectures: $_packagearchitecture" >> conf/distributions
echo "Components: main" >> conf/distributions
echo "Description: the-skycoin-project debian package repository" >> conf/distributions
echo "SignWith: $_signwith" >> conf/distributions
echo "Creating debian package repo"
set -e pipefail


reprepro --basedir $(pwd) includedeb $_debian_codename *.deb
#reprepro --basedir $(pwd) includedeb sid *.deb

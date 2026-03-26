#!/bin/bash

set -oue pipefail #fail on error
set -x #echo on

#install dependencies (for getting release)
apt install -y jq wget

pushd /tmp
wget "$(curl -s https://api.github.com/repos/jatinchowdhury18/AnalogTapeModel/releases/latest | jq -r '.assets[] | select(.name? | match("Linux")) | .browser_download_url')"
apt install -y ./ChowTapeModel-Linux-*.deb
popd

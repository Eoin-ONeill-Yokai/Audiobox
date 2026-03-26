#!/bin/bash

set -oue pipefail #fail on error
set -x #echo on

#install dependencies (for getting release)
apt install -y jq wget

pushd /tmp
wget "$(curl -s https://api.github.com/repos/Chowdhury-DSP/BYOD/releases/latest | jq -r '.assets[] | select(.name? | match("Linux")) | .browser_download_url')"
apt install -y ./*-Linux-*.deb
popd

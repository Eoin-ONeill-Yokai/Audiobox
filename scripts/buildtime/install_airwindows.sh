#!/bin/bash

set -oue pipefail #fail on error
set -x #echo on

#install dependencies (for getting release)
apt install -y jq wget

pushd /tmp
wget "$(curl -s https://api.github.com/repos/baconpaul/airwin2rack/releases/tags/DAWPlugin | jq -r '.assets[] | select(.name? | match("Linux")) | .browser_download_url')"
unzip *-Linux.zip

mkdir -p /usr/lib/vst3
mkdir -p /usr/lib/clap

mv ./awcons-products/*.vst3 /usr/lib/vst3/
mv ./awcons-products/*.clap /usr/lib/clap/

chmod -R +755 /usr/lib/vst3/Airwindows*
chmod -R +755 /usr/lib/clap/Airwindows*

popd

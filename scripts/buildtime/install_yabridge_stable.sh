#!/bin/bash

set -oue pipefail #fail on error
set -x #echo on

#wget -c https://github.com/robbert-vdh/yabridge/releases/download/5.1.0/yabridge-5.1.0.tar.gz -O - | tar -C /usr/local/share -xz

# Automatically fetch the latest stable release of yabrdige from the releases page. 
wget -c "$(curl -s https://api.github.com/repos/robbert-vdh/yabridge/releases/latest | jq -r '.assets[] | select(.name? | match("tar.gz")) | .browser_download_url')" -O - | tar -C /usr/local/share -xz
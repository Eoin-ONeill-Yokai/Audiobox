#!/bin/bash

set -oue pipefail #fail on error
set -x #echo on

# Install yabridge dependencies
apt install --install-recommends -y meson build-essential libxcb1-dev cmake cmake-extras libwine-dev libdbus-glib-1-dev libgirepository1.0-dev winehq-devel wine-devel-dev

# Build yabridge
mkdir -p /src
pushd /src
if [ ! -d "./yabridge" ]; then
    git clone https://github.com/robbert-vdh/yabridge.git
fi
pushd ./yabridge
meson setup build --buildtype=release --cross-file=cross-wine.conf --unity=on --unity-size=1000 # -Dbitbridge=true
ninja -C build
popd
popd

# Install rust

RUSTUP_HOME=/usr/local/rustup
CARGO_HOME=/usr/local/cargo
PATH=/root/.cargo/bin/:$PATH
curl https://sh.rustup.rs -sSf | bash -s -- -y


# Build yabridge-ctl
pushd /src/yabridge/tools/yabridgectl
if [ ! -d "./target" ]; then
    cargo build --release --locked --all-features --target-dir=target
fi
popd


#Install all package files
install -dm755 /usr/local/share/yabridge

pushd /src/yabridge/build
install -m755 yabridge-*.exe{,.so} /usr/local/share/yabridge
install -m755 libyabridge{,-chainloader}-{vst2,vst3,clap}.so /usr/local/share/yabridge
popd

pushd /src/yabridge/tools/yabridgectl
install -m755 ./target/release/yabridgectl /usr/local/share/yabridge
popd

# Automatically fetch the latest stable release of yabrdige from the releases page. 
#wget -c "$(curl -s https://api.github.com/repos/robbert-vdh/yabridge/releases/latest | jq -r '.assets[] | select(.name? | match("tar.gz")) | .browser_download_url')" -O - | tar -C /usr/local/share -xz
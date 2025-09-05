#!/bin/bash

CODENAME=$(lsb_release -cs)

dpkg --add-architecture i386; apt update -y; mkdir -pm755 /etc/apt/keyrings;
wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key;
wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/$CODENAME/winehq-$CODENAME.sources
apt update -y; apt upgrade -y; apt install -y --install-recommends winehq-staging;
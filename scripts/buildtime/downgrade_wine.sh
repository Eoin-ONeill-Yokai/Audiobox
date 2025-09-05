#!/bin/bash

set -oue pipefail #fail on error
set -x #echo on

wine_version=9.21
wine_variant=staging
codename=$(shopt -s nullglob; awk '/^deb https:\/\/dl\.winehq\.org/ { print $3; exit 0 } END { exit 1 }' /etc/apt/sources.list /etc/apt/sources.list.d/*.list || awk '/^Suites:/ { print $2; exit }' /etc/apt/sources.list /etc/apt/sources.list.d/wine*.sources)
suffix=$(dpkg --compare-versions "$wine_version" ge 6.1 && ((dpkg --compare-versions "$wine_version" eq 6.17 && echo "-2") || echo "-1"))
apt install --install-recommends {"winehq-$wine_variant","wine-$wine_variant","wine-$wine_variant-amd64","wine-$wine_variant-i386"}="$wine_version~$codename$suffix"

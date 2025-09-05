FROM quay.io/toolbx/ubuntu-toolbox:latest

#Let ubuntu/debian know we're running in noninteractive mode. (Aka "No questions, please!")
ARG DEBIAN_FRONTEND=noninteractive

RUN lsb_release -a

ARG codename=$(shopt -s nullglob; awk '/^deb https:\/\/dl\.winehq\.org/ { print $3; exit 0 } END { exit 1 }' /etc/apt/sources.list /etc/apt/sources.list.d/*.list || awk '/^Suites:/ { print $2; exit }' /etc/apt/sources.list /etc/apt/sources.list.d/wine*.sources)

ADD ./scripts/buildtime  /usr/bin/buildtime

#Install wine-staging by setting up PPA
RUN /usr/bin/buildtime/install_wine.sh

# Yabridge only supports wine 9.12 for now. Downgrade until the branch merges
RUN /usr/bin/buildtime/downgrade_wine.sh
	
#Install winetricks + dependencies
RUN apt install -y cabextract winetricks

RUN wget -c https://github.com/robbert-vdh/yabridge/releases/download/5.1.0/yabridge-5.1.0.tar.gz -O - | tar -C /usr/local/share -xz

ENV PATH="${PATH}:/usr/local/share/yabridge"

RUN mkdir /etc/skel/Prefixes

#Install pipewire to ensure connection to audio server.
RUN apt install -y pipewire

# In case "pro audio" mode isn't activated or other debugging is needed.
RUN apt install -y pavucontrol

#Install libxcb for bitwig.
RUN apt install -y libxcb-imdkit1

#Install FFMPEG and additional dependencies for audio processing scripts..
RUN apt install -y ffmpeg pipx
RUN pipx install ffmpeg-normalize

#Install all utility scripts into the container
ADD ./scripts/*.sh /usr/bin/
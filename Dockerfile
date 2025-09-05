FROM quay.io/toolbx/ubuntu-toolbox:latest

#Let ubuntu/debian know we're running in noninteractive mode. (Aka "No questions, please!")
ARG DEBIAN_FRONTEND=noninteractive

RUN lsb_release -a

#Install wine-staging by setting up PPA
RUN dpkg --add-architecture i386; apt update -y; mkdir -pm755 /etc/apt/keyrings; \
	wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key; \
	wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/noble/winehq-noble.sources; \
	apt update -y; apt upgrade -y; apt install -y --install-recommends winehq-staging;
	
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

# Yabridge only supports wine 9.12 for now. Downgrade until the branch merges
RUN ./scripts/buildtime/downgrade_wine.sh
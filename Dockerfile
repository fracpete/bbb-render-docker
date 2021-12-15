FROM ubuntu:18.04

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get -y install python3-gi gir1.2-ges-1.0 ges1.0-tools git python3 gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly python3-intervaltree && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /opt

RUN git clone https://github.com/plugorgau/bbb-render.git && \
    cd bbb-render && \
    git reset --hard e137d9d9c72fe7985e72338d4fa0a748f39e2b08

COPY bbbr* /usr/bin/
COPY bash.bashrc /etc/bash.bashrc

WORKDIR /workspace


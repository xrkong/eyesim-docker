FROM ubuntu:20.04 as base
ARG DEBIAN_FRONTEND=noninteractive
USER root
RUN apt-get update && \
  apt-get install -y wget \
    libx11-dev unzip sudo \
    xvfb x11vnc \
    python3 python3-pip 

RUN pip3 install numpy

RUN useradd -m eyesim
#COPY --chown=eyesim:eyesim . /home/eyesim

USER eyesim
WORKDIR /home/eyesim
RUN wget https://roblab.org/eyesim/ftp/EyeSim-1.5.2-Linux.tar.gz && \
  wget https://roblab.org/eyesim/ftp/Eyesim-Examples.zip
RUN tar -xzf EyeSim-1.5.2-Linux.tar.gz && rm EyeSim-1.5.2-Linux.tar.gz && \
  unzip Eyesim-Examples.zip && rm Eyesim-Examples.zip 

USER root
WORKDIR /home/eyesim
RUN cp -r ./eyesimX ./EyeSim && \
  cd EyeSim && ./install.sh

USER eyesim
# Use the CentOS base image
FROM ubuntu:latest

USER root

WORKDIR /opt

RUN apt update && apt upgrade -y
RUN apt install sudo -y
RUN sudo apt install curl wget -y

# Install Git, OpenSSH, python, etc.
RUN sudo apt-get install -y vim git openssh-client openssh-server python3 build-essential cmake openmpi-bin openmpi-common libopenmpi-dev flex sed

# clone the git repository
WORKDIR /usr/lib/openfoam/
RUN git clone https://github.com/Eirene2015/OpenFOAM-v2306-H2Prop.git
RUN mv OpenFOAM-v2306-H2Prop openfoam-v2306-H2Prop


RUN echo 'root:openfoam' | chpasswd
# create new user 
RUN useradd -ms /bin/bash ofuser
RUN echo 'ofuser:openfoam' | chpasswd
RUN echo "source /usr/lib/openfoam/openfoam-v2306-H2Prop/etc/bashrc" >> /home/ofuser/.bashrc

# grant access to ofuser
RUN chown -R ofuser:ofuser /usr/lib/openfoam/openfoam-v2306-H2Prop
# /home/ofuser/.ssh

USER ofuser

# Add the environment variable to ~/.bashrc
ENV WM_PROJECT_DIR=/usr/lib/openfoam/openfoam-v2306-H2Prop
RUN echo 'export WM_PROJECT_DIR="/usr/lib/openfoam/openfoam-v2306-H2Prop"' >> /home/ofuser/.bashrc

# install the openfoam
WORKDIR /usr/lib/openfoam/openfoam-v2306-H2Prop
# RUN ./Allwmake -j 8


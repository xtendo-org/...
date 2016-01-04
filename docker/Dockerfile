FROM debian:sid
MAINTAINER Kinoru <xkinoru@gmail.com>

# development ports
EXPOSE 22 80 443 3000 8000 8080

# package update, upgrade and install
RUN \
    apt-get update && apt-get upgrade -y &&\
    apt-get install -y --no-install-recommends git vim tree curl silversearcher-ag wget openssh-server ca-certificates sudo tmux

# create user
RUN \
    adduser --disabled-password --gecos '' ubuntu &&\
    adduser ubuntu sudo &&\
    # username:password
    echo ubuntu:1234 | chpasswd
USER ubuntu
WORKDIR /home/ubuntu

# configuration
RUN git clone --depth=1 https://github.com/kinoru/....git

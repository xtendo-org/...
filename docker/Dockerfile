FROM debian:sid
MAINTAINER Kinoru <xkinoru@gmail.com>

# development ports
EXPOSE 22 80 443 3000 8000 8080

# package update, upgrade and install
RUN \
    echo "deb ftp://ftp.kr.debian.org/debian sid main" > /etc/apt/sources.list &&\
    apt-get update && apt-get upgrade -y &&\
    apt-get install -y --no-install-recommends apt-utils

RUN apt-get install -y --no-install-recommends locales curl silversearcher-ag wget openssh-server ca-certificates sudo
RUN apt-get install -y --no-install-recommends git vim-nox tree tmux fish

# locale
RUN \
    echo "Asia/Tokyo" > /etc/timezone &&\
    dpkg-reconfigure -f noninteractive tzdata &&\
    sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen &&\
    echo 'LANG="en_US.UTF-8"' > /etc/default/locale &&\
    dpkg-reconfigure --frontend=noninteractive locales &&\
    update-locale LANG=en_US.UTF-8

ENV LC_ALL en_US.UTF-8

# Haskell
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 575159689BEFB442
RUN echo 'deb http://download.fpcomplete.com/debian jessie main' | tee /etc/apt/sources.list.d/fpco.list
RUN apt-get update && apt-get install stack -y

# create user
RUN \
    adduser --disabled-password --gecos '' ubuntu &&\
    adduser ubuntu sudo &&\
    # username:password
    echo ubuntu:1234 | chpasswd
RUN chsh -s /usr/bin/fish ubuntu
USER ubuntu
WORKDIR /home/ubuntu

# configuration
RUN git clone --depth=1 https://github.com/kinoru/....git
RUN \
    mkdir -p ~/.config/fish &&\
    ln -sf ~/.../config.fish ~/.config/fish/config.fish &&\
    ln -sf ~/.../.tmux.conf ~/ &&\
    ln -sf ~/.../.vimrc ~/ &&\
    echo "source ~/.../.bashrc" >> ~/.bashrc
RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim && vim -c "PlugUpdate | qa"
RUN mkdir -p ~/tmp

# SSH
USER root
RUN service ssh start
USER ubuntu


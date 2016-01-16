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
    adduser --disabled-password --gecos '' user &&\
    adduser user sudo &&\
    # username:password
    echo user:1234 | chpasswd
RUN chsh -s /usr/bin/fish user
USER user
WORKDIR /home/user

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

# SSH server
USER root
RUN \
    sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config &&\
    sed -i 's/^#AuthorizedKeysFile /AuthorizedKeysFile /g' /etc/ssh/sshd_config
USER user
RUN \
    mkdir -p ~/.ssh &&\
    echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGg1a5lmF1iEIhYfsb+/4q1qmr7K4PXmObqA4GJ+ixJz user@dev" > ~/.ssh/authorized_keys

# npm
USER root
RUN apt-get install -y nodejs-legacy npm

# pyenv
RUN apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev llvm libncurses5-dev
RUN curl -L https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | bash

RUN mkdir /var/run/sshd
RUN echo "export VISIBLE=now" >> /etc/profile
CMD ["/usr/sbin/sshd", "-D"]

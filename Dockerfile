FROM ubuntu:15.04
MAINTAINER Kinoru <xkinoru@gmail.com>

# development ports
EXPOSE 22 80 443 3000 8000 8080

# package update, upgrade and install
RUN \
    apt-get update && apt-get upgrade -y &&\
    apt-get install -y --no-install-recommends git vim tree curl silversearcher-ag wget openssh-server ca-certificates sudo tmux

# locale
RUN \
    locale-gen en_US.UTF-8 &&\
    dpkg-reconfigure locales &&\
    echo "LANG=en_US.UTF-8" > /etc/default/locales

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
RUN ln -s ~/.../.vimrc ~/ && ln -s ~/.../.tmux.conf ~/ && ln -s ~/.../.inputrc ~/
RUN echo "source ~/.../.bashrc" >> ~/.bashrc

# install vim-plug and plugins
RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim && vim -c "PlugInstall | qa"

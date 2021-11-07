FROM ubuntu:latest

RUN apt-get update && apt-get install -y \
    vim \
    tmux \
    git \
    sudo \
    python3 \
    curl \
    python3-pip

RUN useradd --create-home --shell /bin/bash user
RUN usermod -aG sudo user
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER user
WORKDIR /home/user

ENV TERM=xterm-256color

COPY .tmux.conf .
COPY .vimrc .
COPY .zshrc .

# isntall vim-plug
RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# install cscope-maps plugin dependency
#RUN curl -fLo ~/.vim/plugged/cscope-maps/plugin/cscope_maps.vim --create-dirs \
#    https://raw.githubusercontent.com/joe-skb7/cscope-maps/master/plugin/cscope_maps.vim

#RUN vim -es -u vimrc -i NONE -c "PlugInstall" -c "qa"

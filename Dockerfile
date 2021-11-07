FROM ubuntu:latest

RUN apt-get update && apt-get install -y \
    vim \
    tmux \
    git \
    sudo \
    python3 \
    python3-pip

RUN useradd --create-home --shell /bin/bash user
RUN usermod -aG sudo user
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER user
WORKDIR /home/user

COPY .tmux.conf .
COPY .vimrc .
COPY .zshrc .
    

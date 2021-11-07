FROM ubuntu:latest

RUN apt-get update && apt-get install -y \
    vim \
    tmux \
    git \
    sudo \
    python3 \
    curl \
    clang \
    zsh \
    wget \
    python3-pip

# create a non-root user
RUN useradd --create-home --shell /bin/bash user
RUN usermod -aG sudo user
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# change to normal user
USER user
WORKDIR /home/user

# some vim plugins require this
ENV TERM=xterm-256color

COPY .tmux.conf .
COPY .vimrc .
COPY .zshrc .

# isntall vim-plug
RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# insatll vim plugins from command line, exit 0 because the pluginstall script exits with 1, failing the build
RUN vim -es -u ~/.vimrc -i NONE -c "PlugInstall" -c "qa"; exit 0

# install oh-my-zsh
RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true

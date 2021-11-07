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
    fzf \
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
COPY .fzf.zsh .

# isntall vim-plug
RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# insatll vim plugins from command line, exit 0 because the pluginstall script exits with 1, failing the build
RUN vim -es -u ~/.vimrc -i NONE -c "PlugInstall" -c "qa"; exit 0

# install oh-my-zsh
RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true

# replace default zshrc
COPY .zshrc .

# install zsh-syntax-highlighting
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# install zsh-autosuggestions
RUN git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

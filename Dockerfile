FROM ubuntu:latest

RUN apt-get update && apt-get install -y \
    vim \
    tmux \
    silversearcher-ag \
    git \
    sudo \
    python3 \
    curl \
    clang \
    zsh \
    wget \
    fzf \
    python3-pip \
    iputils-ping \
    golang \
    npm \
    universal-ctags

# some global updates...
RUN go install -v golang.org/x/tools/gopls@latest

# get the latest version of Node.js
RUN npm install -g npm@latest
RUN npm cache clean -f
RUN npm install -g n
RUN n stable
RUN npm install -g jshint

# create a non-root user and add them to sudoers
RUN useradd --create-home --shell /bin/bash user
RUN usermod -aG sudo user
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# change to normal user
USER user
WORKDIR /home/user

# some vim plugins require this
ENV TERM=xterm-256color

# copy dotfiles into container
COPY .tmux.conf .
COPY .vimrc .
COPY .fzf.zsh .
COPY .clang-format .

# install docker
COPY install-docker.sh .
RUN bash install-docker.sh
RUN rm install-docker.sh

# install vim-plug
RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# insatll vim plugins from command line, exit 0 because the pluginstall script exits with 1, failing the build
RUN vim -es -u ~/.vimrc -i NONE -c "PlugInstall" -c "qa"; exit 0

# install oh-my-zsh
RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true

# install zsh-syntax-highlighting
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# install zsh-autosuggestions
RUN git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# replace default zshrc
COPY .zshrc .


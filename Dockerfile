FROM alpine:3.7
RUN apk update && \
    apk add --no-cache sudo && \
    apk add --no-cache vim && \
    apk add --no-cache python3 && \
    apk add --no-cache tmux && \
    apk add --no-cache ctags && \
    apk add --no-cache git && \
    apk add --no-cache python3 && \
    apk add --no-cache curl && \
    apk add --no-cache llvm && \
    apk add --no-cache bash && \
    apk add --no-cache python-dev && \
    apk add --no-cache zsh 

# User config
ENV UID="1000" \
    UNAME="waterproofpatch" \
    GID="1000" \
    GNAME="waterproofpatch" \
    SHELL="/bin/bash" \
    UHOME=/home/waterproofpatch

# User

RUN \
# Create hmoe directory
    mkdir -p "${UHOME}" \
    && chown "${UID}":"${GID}" "${UHOME}" \
# Create user
    && echo "${UNAME}:x:${UID}:${GID}:${UNAME},,,:${UHOME}:${SHELL}" \
    >> /etc/passwd \
    && echo "${UNAME}::17032:0:99999:7:::" \
    >> /etc/shadow \
    # No password sudo
    && echo "${UNAME} ALL=(ALL) NOPASSWD: ALL" \
    > "/etc/sudoers.d/${UNAME}" \
    && chmod 0440 "/etc/sudoers.d/${UNAME}" \
    # Create group
    && echo "${GNAME}:x:${GID}:${UNAME}" \
    >> /etc/group

USER $UNAME

# install oh-my-zsh
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

RUN mkdir -p "${UHOME}/git/dotfiles/zsh" 

COPY vim/vimrc $UHOME/.vimrc
COPY zsh/zshrc $UHOME/.zshrc
COPY zsh/keybindings.sh $UHOME/git/dotfiles/zsh/keybindings.sh
COPY zsh/prompt.sh $UHOME/git/dotfiles/zsh/prompt.sh
COPY zsh/zsh-autosuggestions $UHOME/git/dotfiles/zsh/zsh-autosuggestions
COPY zsh/zsh-syntax-highlighting $UHOME/git/dotfiles/zsh/zsh-syntax-highlighting

WORKDIR $UHOME

ENTRYPOINT ["zsh"]

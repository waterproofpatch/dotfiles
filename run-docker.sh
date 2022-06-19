#!/bin/bash
COMMON_FLAGS="--net=host --privileged=true -v /var/run/docker.sock:/var/run/docker.sock"

if [ -z "$1" ]; then
        echo "Not mounting any dir"
        docker run $COMMON_FLAGS -it dev /bin/zsh
        exit 1
else
        echo "Mounting $1 to ~/workspace..."
        docker run $COMMON_FLAGS --mount type=bind,source=$1,target=/home/user/workspace -it dev /bin/zsh 
fi

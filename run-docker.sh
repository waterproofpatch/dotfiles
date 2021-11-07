if [ -z "$1" ]; then
        echo "Must specify FQP to dir to mount"
        exit 1
fi
docker run --mount type=bind,source=$1,target=/home/user/workspace -it dev /bin/zsh

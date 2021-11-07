if [ -z "$1" ]; then
        echo "Not mounting any dir"
        docker run -it dev /bin/zsh
        exit 1
else
        docker run --mount type=bind,source=$1,target=/home/user/workspace -it dev /bin/zsh
fi

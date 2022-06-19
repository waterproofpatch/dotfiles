if [ -z "$1" ]; then
        echo "Not mounting any dir"
        docker run -it dev /bin/zsh
        exit 1
else
        echo "Mounting $1 to ~/workspace..."
        docker run --net=host --mount type=bind,source=$1,target=/home/user/workspace -it dev /bin/zsh
fi

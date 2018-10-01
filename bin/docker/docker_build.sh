#!/bin/bash
source $(dirname $0)/docker_env.sh

# parse options
while [ $# -gt 0 ]; do
    case $1 in
        -h|--help)
            echo "usage: $SCRIPT_NAME [-h] [-i|--image] [-f|--force]"
            echo "  -h, --help       show help and exit"
            echo "  -i, --image      specify image (Dockerfile without extention)"
            echo "  -f, --force      replace existing image"
            exit 0
        ;;

        -i|--image)
            if [ ! -z "$2" ]; then
                PARAM_IMAGE=$2
                shift 2
                continue
            else
                echo 1>&2 "ERROR: Must specify a non-empty value for $1"
                exit 1
            fi
        ;;

        -f|--force)
            PARAM_FORCE=1
            shift 1
            continue
        ;;

        *)
            echo 1>&2 "ERROR: Unknown option or value: $1"
            exit 1
        ;;
    esac
done

# check image parameter
removeDockerExtention $PARAM_IMAGE DOCKER_IMAGE_NAME
DOCKER_FILE="$DOCKER_IMAGE_NAME.Dockerfile"
if [ ! -e $DOCKER_FILE ]; then
    echo 1>&2 "ERROR: File '$DOCKER_FILE' does not exist"
    echo 1>&2 "Image name is invalid. Available images:"
    for i in $(ls *.Dockerfile); do
        removeDockerExtention $i name
        echo 1>&2 "  $name"
    done
    exit 1
fi

contId=$($SUDO docker images $DOCKER_IMAGE_NAME -q)
if [ ! -z "$contId" ]; then
    if [ ! -z "$PARAM_FORCE" ]; then
        $SUDO docker rmi -f $contId > /dev/null
        echo "The following image (-s) has been forcely removed: $contId"
    else
        echo "Image already exists. Remove it before."
        exit 1
    fi
fi

$SUDO docker build -t $DOCKER_IMAGE_NAME:v1 -f $DOCKER_FILE .

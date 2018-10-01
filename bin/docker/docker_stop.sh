#!/bin/bash
source $(dirname $0)/docker_env.sh

# parse options
while [ $# -gt 0 ]; do
    case $1 in
        -h|--help)
            echo "usage: $SCRIPT_NAME [-h] [-i|--image] [-c|--clean]"
            echo "  -h, --help       show help and exit"
            echo "  -i, --image      specify image (Dockerfile without extention)"
            echo "  -c, --clean      clean any changes in container"
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

        -c|--clean)
            PARAM_CLEAN=1
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

# stop container
ID=$($SUDO docker ps -a -f name=$DOCKER_IMAGE_NAME -f status=running -q)
if [ ! -z "$ID" ]; then
    $SUDO docker stop $ID >/dev/null
    echo "Container $DOCKER_IMAGE_NAME ($ID) has been stopped"
else
    echo "Container $DOCKER_IMAGE_NAME isn't running"
fi

ID=$($SUDO docker ps -q -a -f name=$DOCKER_IMAGE_NAME -f status=exited -f status=dead)
if [[ ! -z "$PARAM_CLEAN" && ! -z "$ID" ]]; then
    $SUDO docker rm $ID >/dev/null
    echo "Container $DOCKER_IMAGE_NAME ($ID) has been removed"
fi

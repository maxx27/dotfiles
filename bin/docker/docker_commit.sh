#!/bin/bash
source $(dirname $0)/docker_env.sh

# parse options
while [ $# -gt 0 ]; do
    case $1 in
        -h|--help)
            echo "usage: $SCRIPT_NAME [-h] [-i|--image]"
            echo "  -h, --help       show help and exit"
            echo "  -i, --image      specify image (Dockerfile without extention)"
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

        *)
            echo 1>&2 "ERROR: Unknown option or value: $1"
            exit 1
        ;;
    esac
done

# check image parameter
removeDockerExtention $PARAM_IMAGE DOCKER_IMAGE_NAME

# commit changes
# TODO: user can stop container -> use stopped container
contId=$($SUDO docker ps -a -f name=$DOCKER_IMAGE_NAME -q)
if [ -z "$contId" ]; then
    echo "Container isn't running. Nothing to commit."
    exit 0
fi

# find latest and next tag version
getDockerLatestTag $DOCKER_IMAGE_NAME imageTag
if [[ $imageTag =~ ^v([0-9]+)$ ]]; then
    newTag=v$(( ${BASH_REMATCH[1]} + 1 ))
else
    echo 1>&2 "Tag is not proper format; use $newTag as new tag value";
    exit 1
fi

# commit current state as new image
# NB: it is not needed to stop it before committed
$SUDO docker commit $contId $DOCKER_IMAGE_NAME:$newTag
echo "Container $contId has been saved as $DOCKER_IMAGE_NAME:$newTag";

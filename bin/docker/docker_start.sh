#!/bin/bash
source $(dirname $0)/docker_env.sh

# parse options
while [ $# -gt 0 ]; do
    case $1 in
        -h|--help)
            echo "usage: $SCRIPT_NAME [-h] [-i|--image] [-d|--dir] [-x|--x]"
            echo "  -h, --help       show help and exit"
            echo "  -i, --image      specify image (Dockerfile without extention)"
            echo "  -d, --dir        specify home directory (\$HOME by default)"
            echo "  -x, --x          forward X11 (none, unix)"
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

        -d|--dir)
            if [ ! -z "$2" ]; then
                PARAM_HOME=$2
                shift 2
                continue
            else
                echo 1>&2 "ERROR: Must specify a non-empty value for $1"
                exit 1
            fi
        ;;

        -x|--x)
            if [ ! -z "$2" ]; then
                PARAM_X=$2
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

# check home parameter
PARAM_HOME=$(realpath $PARAM_HOME) # make absolute path (important for docker)
fixPath $PARAM_HOME PARAM_HOME
if [ ! -d $PARAM_HOME ]; then
    echo 1>&2 "No directory $PARAM_HOME found for home user content"
    echo 1>&2 "Please create it, add ssh keys, default settings, etc"
    exit 1
fi

# check X forwarding parameter
case $PARAM_X in
    unix)
        if [ $OS != 'linux' ]; then
            echo 1>&2 "ERROR: Unsupported OS param value for current host: $PARAM_X"
            exit 1
        fi
        PARAM_X="-e DISPLAY=unix$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix"
        ;;
    none)
        PARAM_X=
        ;;
    *)
        echo 1>&2 "ERROR: Unsupported X param value: $PARAM_X"
        exit 1
esac

# continue working if possible
ID=$($SUDO docker ps -a -f name=$DOCKER_IMAGE_NAME -q)
if [ ! -z "$ID" ]; then
    $SUDO docker start -ai $DOCKER_IMAGE_NAME
    exit 0
fi

# DK_ROOT is needed for a first run. Later we'll use the cached value
if [ -z "$DK_ROOT" ]; then
    echo 1>&2 "No DK found. set DK_ROOT variable."
    exit 1
fi

# find latest tag
getDockerLatestTag $DOCKER_IMAGE_NAME imageTag
if [ -z $imageTag ]; then
    echo 1>&2 "No image $DOCKER_IMAGE_NAME found. Build it before start."
    exit 1
fi

# start new instance
$SUDO docker run -v $DK_ROOT:/opt/DK -v $PARAM_HOME:/home/user $PARAM_X -it --name $DOCKER_IMAGE_NAME $DOCKER_IMAGE_NAME:$imageTag

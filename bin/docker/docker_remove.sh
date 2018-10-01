#!/bin/bash
source $(dirname $0)/docker_env.sh

# parse options
MODE='-l'
while [ $# -gt 0 ]; do
    case $1 in
        -h|--help)
            echo "usage: $SCRIPT_NAME [-h] [-i|--image] [-A|--all] [-l|--last] [-n|--none] [-d|--dangling]"
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

        -A|--all)
            MODE='-a'
            shift 1
            continue
        ;;

        -l|--last)
            MODE='-l'
            shift 1
            continue
        ;;

        -f|--except-first)
            MODE='-f'
            shift 1
            continue
        ;;

        -n|--none)
            MODE='-n'
            shift 1
            continue
        ;;

        -d|--dangling)
            MODE='-d'
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

# do actions
case $MODE in
    -a)
        # skip header
        CMD="$SUDO docker images $DOCKER_IMAGE_NAME | tail -n +2"
    ;;

    -l)
        # skip header and take the newest image
        CMD="$SUDO docker images $DOCKER_IMAGE_NAME | tail -n +2 | head -n 1"
    ;;

    -f)
        # skip header and last (earliest) image
        CMD="$SUDO docker images $DOCKER_IMAGE_NAME | tail -n +2 | head -n -1"
    ;;

    -n)
        CMD="$SUDO docker images | grep '^<none>'"
    ;;

    -d)
        CMD="$SUDO docker images -f 'dangling=true'"
    ;;

    *)
        echo 1>&2 "ERROR: Unknown mode: $1"
        exit 1
    ;;
esac

OLDIFS=$IFS
IFS=$'\r\n'
for imageLine in $(eval $CMD); do
    # parse the following output
    # ubuntu12.x64    v2                  3e2eb1ca43ee        3 minutes ago       420MB
    # ubuntu12.x64    v1                  d51f0d5c4c67        10 hours ago        420MB
    IFS=' '
    imageStats=($imageLine)
    imageName=${imageStats[0]}
    imageTag=${imageStats[1]}
    imageId=${imageStats[2]}

    $SUDO docker rmi -f $imageId >/dev/null
    echo "Image $imageName:$imageTag with id $imageId has been removed"
done
IFS=$OLDIFS

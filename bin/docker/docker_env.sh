#!/bin/bash

SCRIPT_DIR=$(dirname $(readlink -f $0))
SCRIPT_NAME=$(basename $(readlink -f $0))

# check for sudo necessity
case "$(uname -s)" in
    Linux*)
        # if user has permissions to run docker without sudo
        if grep -qE "^docker:.*$USER" /etc/group; then
            SUDO=
        else
            SUDO=sudo
        fi
    ;;
    # Darwin*)    SUDO=Mac;;
    # CYGWIN*)    SUDO=Cygwin;;
    MINGW*)
        SUDO=
        export DK_ROOT=$(echo $DK_ROOT | sed 's=\\=/=g')
    ;;
    *)
        SUDO=sudo
esac


# check for host OS
case "$(uname -s)" in
    Linux*)
        OS=linux
    ;;
    # Darwin*)    SUDO=Mac;;
    # CYGWIN*)    SUDO=Cygwin;;
    MINGW*)
	OS=windows
    ;;
    *)
        OS=unknown
esac

# fixPath 'C:\Program Files\Docker\Docker\Resources\bin\docker.exe' result
# echo 1: $result
# fixPath '/d/Work/Populus/Repo/DK/bin/docker_utils' result
# echo 2: $result
function fixPath()
{
    local path=$1
    local resVar=$2
    case "$(uname -s)" in
    MINGW*)
        # NB: \' ... \' is needed for path with spaces -> eval var='value with spaces' -> works fine
        eval $resVar=\'$(echo $path | sed 's=\\=/=g' | sed 's=^/\([a-zA-Z]\)/=\1:/=')\'
        ;;
    *)
    esac
}

# getDockerLatestTag $DOCKER_IMAGE_NAME result
# echo $result
function getDockerLatestTag()
{
    local imageName=$1
    local resVar=$2
    eval $resVar=$($SUDO docker images $imageName | tail -n +2 | head -n 1 | awk '{print $2}')
}

# isImageExists 'ubuntu12.x64' result
# echo 1: $result
# isImageExists 'ubu12.x64' result
# echo 2: $result
function isImageExists()
{
    local imageName=$1
    local resVar=$2
    if [[ $($SUDO docker images $imageName | tail -n +2 | wc -c) -ne 0 ]]; then
        eval $resVar=1
    else
        eval $resVar=
    fi
}

# Remove '.Dockerfile' extention if any
# to easy specify image name with autocompletion from shell
function removeDockerExtention()
{
    local imageName=$1
    local resVar=$2
    [[ $imageName =~ (.*)\.Dockerfile$ ]] || [[ $imageName =~ (.*)$ ]]
    eval $resVar=${BASH_REMATCH[1]}
}

# default options values
PARAM_CLEAN=
PARAM_FORCE=
PARAM_HOME=$HOME
PARAM_IMAGE=ubuntu12.x64
PARAM_X=none

if [ -z "$DOCKER_IMAGE_NAME" ]; then
    removeDockerExtention $PARAM_IMAGE DOCKER_IMAGE_NAME
fi

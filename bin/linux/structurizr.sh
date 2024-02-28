#!/bin/bash -e

# Script to run structurizr in specific folder via docker container.
# Typical usage:
# ./structurizr.sh start
# ./structurizr.sh stop

args=$@

operation=""
dirname="$(pwd)"
filename=workspace # without .dsl or .json extension
port="8080"
cont="structurizr"
label="structurizr"
deamon="-d"

function startDevelopmentContainer() {
    check_filename="$dirname/$filename.dsl"
    if [[ ! -e $check_filename ]]; then
        # to avoid creation of new empty files (probably by mistake)
        echo "ERROR: $check_filename does not exist"
        exit 1
    fi
    docker pull structurizr/lite
    set -x
    docker run $deamon --rm \
        -l "$label" \
        --name "$cont" \
        -p $port:8080 \
        -v "$dirname":/usr/local/structurizr \
        -e STRUCTURIZR_WORKSPACE_FILENAME="$filename" \
        structurizr/lite
    set +x
}

function stopDevelopmentContainer(){
    # stopping using label
    id=$(docker ps -q --filter "label=$label")
    if [[ ! -z "$id" ]]; then
        docker stop $id
    fi
}

function parseWorkspaceArg(){
    set -- ${args}
    positional_args=()

    while [[ $# -gt 0 ]]; do
        case $1 in
            -d|--dir)
                dirname="$2"
                shift # past argument
                shift # past value
                ;;
            -f|--file)
                filename="$2"
                if [[ $filename == *.dsl || $filename == *.json ]]; then
                    echo "WARNING: remove file extension"
                    filename=${filename%.*}
                fi
                shift # past argument
                shift # past value
                ;;
            -p|--port)
                port="$2"
                shift # past argument
                shift # past value
                ;;
            -c|--container)
                name="$2"
                shift # past argument
                shift # past value
                ;;
            -l|--label)
                label="$2"
                shift # past argument
                shift # past value
                ;;
            -i)
                deamon=""
                shift # past argument
                ;;
            -*|--*)
                echo "Unknown option $1"
                exit 1
                ;;
            *)
                positional_args+=("$1") # save positional arg
                shift # past argument
                ;;
        esac
    done

    set -- "${positional_args[@]}" # restore positional parameters
    len=${#positional_args[@]}

    if [[ ${#positional_args[@]} == 0 || ${positional_args[0]} == "help" ]]; then
        operation="help"
    elif [[ ${positional_args[0]} == "start" ]]; then
        operation="start"
    elif [[ ${positional_args[0]} == "stop" ]]; then
        operation="stop"
    else
        operation="help-error"
    fi
}

function echoHelp(){
    echo "  Usage:"
    echo "  ./structurizr.sh [help]"
    echo "  ./structurizr.sh start [-d DIR] [-f FILE] [-p PORT] [-c CONTAINER] [-l LABEL] [-i]"
    echo "  ./structurizr.sh stop"
    echo "      DIR        workspace directory"
    echo "      FILE       DSL filename (without .dsl or .json)"
    echo "      PORT       local port to share access"
    echo "      CONTAINER  container name"
    echo "      LABEL      custom label to help users filter on running containers"
}

parseWorkspaceArg

echo ""
echo "Debug information:"
echo "operation: $operation"
echo "  dirname: $dirname"
echo " filename: $filename"
echo "     port: $port"
echo "     cont: $cont"
echo "    label: $label"
echo "   deamon: $deamon"
echo ""

if [[ $operation == "help" ]]; then
    echoHelp
elif [[ $operation == "help-error" ]]; then
    echoHelp
    exit 1
elif [[ $operation == "start" ]]; then
    startDevelopmentContainer
elif [[ $operation == "stop" ]]; then
    stopDevelopmentContainer
else
    echo "ERROR: Unknown operation"
    exit 1
fi

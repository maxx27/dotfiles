#!/bin/bash -ex

width=1280 # default
positional=()
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -w|--width)
            width="$2"
            shift # past -w
            shift # past value
            ;;
        -*|--*)
            echo "Unknown option $1"
            exit 1
            ;;
        *)
            positional+=("$1") # save positional arg
            shift # past argument
            ;;
    esac
done

# restore positional parameters $1, $2, etc.
set -- "${positional[@]}"

# '(136/135/134)+140'
# FORMAT='m3u8-1544-0'
# FORMAT='bv*[ext=mp4][width<=1280]+ba[ext=m4a]/b[ext=mp4]/b[width<=1280]'
# FORMAT='bv*[ext=mp4][width<=900]+ba[ext=m4a]/b[ext=mp4][width<=900]/b[width<=900]'
FORMAT="bv*[ext=mp4][width<=$width]+ba[ext=m4a]/b[ext=mp4]/b[width<=$width]"

if [ $# -ne 0 ]; then
    if [[ $1 == *"playlist"* ]]; then
        yt-dlp -f "$FORMAT" -o '%(playlist)s/%(playlist_index)s. %(title)s.%(ext)s' $*
    else
        yt-dlp -f "$FORMAT" $*
    fi
else
    yt-dlp -f "$FORMAT" --no-playlist --batch-file download.txt
fi

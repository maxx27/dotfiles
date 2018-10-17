
# use two console

get from target:
sudo sh -c 'cat -v /dev/ttyUSB0 | grep -E -v "^(slp|write address|procman|odigateway)"'

send to target:
sudo sh -c 'cat > /dev/ttyUSB0'


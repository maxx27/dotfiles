
Then install cert manually:

$ echo | openssl s_client -connect get.docker.com:443 2>/dev/null | sudo sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' | sudo tee '/usr/local/share/ca-certificates/get_docker_com.crt'


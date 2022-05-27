# source start_agent.sh
SSH_ENV="$HOME/.ssh/environment"
function start_agent {
     if [ -f "${SSH_ENV}" ]; then
          . "${SSH_ENV}"
          if ps -fp ${SSH_AGENT_PID} | grep -q ssh-agent$; then
               echo "SSH agent is already running"
               return
          fi
     fi

     echo "Run new SSH agent"
     /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
     chmod 600 "${SSH_ENV}"
     . "${SSH_ENV}"
     /usr/bin/ssh-add
}

start_agent

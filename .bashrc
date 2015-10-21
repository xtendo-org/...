export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

# Default: PS1='[\u@\h \W]\$ '
PS1='\[\e[0;37m\]\[\e[44m\]\w \[\e[0;34m\]\[\e[0m\] '

alias apt-get='apt-get --no-install-recommends'

export HALCYON_GHC_VERSION=7.10.1
export HALCYON_CABAL_VERSION=1.22.6.0

# Always have only one instance of ssh-agent
if ! pgrep -u $USER ssh-agent > /dev/null; then
    ssh-agent > ~/..ssh-agent
fi
if [[ "$SSH_AGENT_PID" == "" ]]; then
    eval `head -n 2 ~/..ssh-agent`
fi

# Stop the pesky Ctrl-S behavior.
# Seriously, it's 2015 and we don't need
# the legacy of teletype speed control.
stty stop undef

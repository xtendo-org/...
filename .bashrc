export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

# Default: PS1='[\u@\h \W]\$ '
PS1='\[\e[0;37m\]\[\e[43m\]\w \[\e[0;33m\]\[\e[0m\] '

alias apt-get='apt-get --no-install-recommends'

export HALCYON_GHC_VERSION=7.10.1
export HALCYON_CABAL_VERSION=1.22.6.0

# Always have only one instance of ssh-agent
if [[ "$SSH_AGENT_PID" == "" ]]; then
    if ! pgrep ssh-agent > /dev/null; then
        ssh-agent -c > ~/..ssh-agent
        eval `head -n 2 ~/..ssh-agent`
        echo "ssh-agent initialized"
    else
        eval `head -n 2 ~/..ssh-agent`
        echo "ssh-agent exported"
    fi
fi

# Stop the pesky Ctrl-S behavior.
# Seriously, it's 2015 and we don't need
# the legacy of teletype speed control.
stty stop undef

# PATH
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

# if pyenv exists, execute "pyenv init -"
type -P "pyenv" > /dev/null && eval "$(pyenv init -)"

# if rbenv exists, execute "rbenv init -"
type -P "rbenv" > /dev/null && eval "$(rbenv init -)"

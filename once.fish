set -x fish_greeting

# tartar configuration

set -x TARTAR_PATH_BG 9cf
set -x TARTAR_PATH_FG black

# set ssh-agent
if [ -z $SSH_AUTH_SOCK ]
    if not pgrep ssh-agent > /dev/null
        ssh-agent -c | head -n 2 | source
    else
        set -x SSH_AUTH_SOCK (ls /tmp/ssh-*/agent.*)
    end
end

set -x PATH $HOME/.local/bin $PATH
set -x PATH $HOME/.../bin $PATH
# for p in (find $HOME/.apps/**/bin | ag /bin\$)
#     set PATH $p $PATH
# end

# OS X coreutils (installed with brew)
if [ -d /usr/local/opt/coreutils/libexec/gnubin/ ]
    set -x PATH /usr/local/opt/coreutils/libexec/gnubin $PATH
end

# pyenv
if [ -d ~/.pyenv ]
    set -gx PATH $HOME"/.pyenv/bin" $PATH
    . (pyenv init -|psub)
    status --is-interactive; and source (pyenv virtualenv-init -|psub)
end

# rbenv
if [ -d ~/.rbenv ]
    set -x PATH $HOME"/.rbenv/bin" $PATH
    . (rbenv init -|psub)
end

# autojump
source /usr/share/autojump/autojump.fish

# cargo
set -x PATH $HOME/.cargo/bin $PATH

# fzf to use ripgrep
set -x FZF_DEFAULT_COMMAND 'rg --files --hidden --follow --glob "!.git/*"'

set -x ARDUINO_PATH /usr/local/arduino

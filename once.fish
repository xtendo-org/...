set -x fish_greeting

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
set PNPM_PACKAGES "$HOME/.pnpm-packages"
set PATH $PATH $PNPM_PACKAGES/bin

set -gx PNPM_HOME "/home/user/.local/share/pnpm"
set -gx PATH "$PNPM_HOME" $PATH

# pyenv
if [ -d ~/.pyenv ]
    set -gx PATH $HOME"/.pyenv/bin" $PATH
    # . (pyenv init -|psub)
    # status --is-interactive; and source (pyenv virtualenv-init -|psub)
    status --is-interactive; and pyenv init - | source
    status --is-interactive; and pyenv virtualenv-init - | source
end

# rbenv
if [ -d ~/.rbenv ]
    set -x PATH $HOME"/.rbenv/bin" $PATH
    . (rbenv init -|psub)
end

# autojump
[ -f /usr/share/autojump/autojump.fish ]; and source /usr/share/autojump/autojump.fish

# cargo
set -x PATH $HOME/.cargo/bin $PATH

# fzf to use ripgrep
set -x FZF_DEFAULT_COMMAND 'rg --files --hidden --follow --glob "!.git/*"'

set -x ARDUINO_PATH /usr/local/arduino

set -x LS_COLORS $LS_COLORS'ow=97;40'

set -x PATH "/opt/flutter/bin" $PATH

# set -Ux PYENV_ROOT $HOME/.pyenv
# set -U fish_user_paths $PYENV_ROOT/bin $fish_user_paths

# status is-login; and pyenv init --path | source
# pyenv init - | source

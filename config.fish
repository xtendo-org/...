set fish_greeting

function prompt_long_pwd --description 'Print the current working directory'
    set -l maybe_pwd (echo $PWD | sed -e "s|^$HOME|~|")
    if echo $maybe_pwd | grep -q "^~/code/"
        echo $maybe_pwd | sed -e "s|^~/code/||"
    else
        if echo $maybe_pwd | grep -q "^~/work/"
            echo $maybe_pwd | sed -e "s|^~/work/||"
        else
            echo $maybe_pwd
        end
    end
end

# tartar configuration

set TARTAR_PATH_BG 9cf
set TARTAR_PATH_FG black

function hunt
    ps aux | grep $argv | grep -v grep | awk '{print $2}'
end

# set ssh-agent
if [ -z $SSH_AUTH_SOCK ]
    if not pgrep ssh-agent > /dev/null
        ssh-agent -c | head -n 2 | source
    else
        set SSH_AUTH_SOCK (ls /tmp/ssh-*/agent.*)
    end
end

set PATH $HOME/.cabal/bin $PATH
set PATH $HOME/.local/bin $PATH
# for p in (find $HOME/.apps/**/bin | ag /bin\$)
#     set PATH $p $PATH
# end

# OS X coreutils (installed with brew)
if [ -d /usr/local/opt/coreutils/libexec/gnubin/ ]
    set PATH /usr/local/opt/coreutils/libexec/gnubin $PATH
end

# Set $GOPATH if there's a Go workspace
if [ -d ~/work/go/ ]
    setenv GOPATH ~/work/go
    set PATH $GOPATH"/bin" $PATH
end

# rbenv
if [ -d ~/.rbenv ]
    set -x PATH $HOME"/.rbenv/bin" $PATH
    . (rbenv init -|psub)
end

# aliases
alias u "unbreak open"
alias v "vim --servername (random)"
function vs
    if [ -e Session.vim ]
        vim --servername (random) -S
    else
        vim --servername (random) -c ':Obsession'
    end
end

# Directory-based pyenv-virtualenv
function _pyenv-virtualenv
    if [ -e .pyenv-virtualenv ]
        [ (cat .pyenv-virtualenv) = (basename "$PYENV_VIRTUAL_ENV") ]
        or pyenv activate --quiet (cat .pyenv-virtualenv)
    else
        [ "$PYENV_VIRTUAL_ENV" = '' ]
        or pyenv deactivate
    end
end

function __check_pwd --on-variable PWD --description 'PWD change hook'
    status --is-command-substitution; and return
    # set tmux window name
    if [ $TMUX ]
        set -l current_path (prompt_long_pwd)
        if [ $current_path != "/" ]
            # set -l current_path (basename $current_path | sed -e "s| |\\\\ |g")
            set current_path (basename $current_path)
        end
        tmux rename-window $current_path
    end
    _pyenv-virtualenv
end

_pyenv-virtualenv

# Change Ctrl+w to delete up to the last whitespace;
# use Alt+Backspace for deleting path components.
bind \cw backward-kill-bigword

# z
function fasd_cd
  # if no $argv, identical with `fasd`
  if test (count $argv) -le 1
    command somethingelse "$argv"
  else
    set -l ret (command somethingelse -e 'printf %s' $argv)
    test -z "$ret";
      and return
    test -d "$ret";
      and cd "$ret";
      or printf "%s\n" $ret
  end
end
function z
  fasd_cd -d $argv
end

# chips
if [ -e ~/.config/chips/build.fish ] ; . ~/.config/chips/build.fish ; end
alias chipsedit "v ~/.config/chips/plugin.yaml"

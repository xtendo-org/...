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

# tartar begins

set -g tartar_bg NONE

function prompt_open
    echo -n (set_color -b $argv[1])(set_color $argv[2]) ''
    set tartar_bg $argv[1]
end

function prompt_transition
    # argv 1: new background color
    # argv 2: new foreground color
    echo -n '' (set_color -b $argv[1])(set_color $tartar_bg)\uE0B0(set_color $argv[2]) ''
    set tartar_bg $argv[1]
end

function prompt_close
    echo -n '' (set_color -b normal)(set_color $tartar_bg)\uE0B0(set_color normal) ''
end

function fish_prompt
    # hostname
    prompt_open blue white
    echo -n (hostname)

    # path
    prompt_transition black white
    echo -n (prompt_long_pwd)

    # pyenv
    if [ $PYENV_VIRTUAL_ENV ];
        prompt_transition magenta white
        echo -n (basename $PYENV_VIRTUAL_ENV);
    end

    # git
    set -l git_dir (git rev-parse --git-dir 2> /dev/null)
    if test -n "$git_dir"
        set -l branch (git branch 2> /dev/null | grep -e '\* ' | sed 's/^..\(.*\)/\1/')
        if test "$branch" = 'master'
            set branch ''
        end
        set -l git_status (git status -s 2> /dev/null)
        if test -n "$git_status"
            set git_color yellow
        else
            set git_color green
        end
        set -l git_ahead (git rev-list origin/master.. 2> /dev/null | wc -l | tr -d '[:space:]')
        if git status -s 2> /dev/null | grep -q "^??"
            set git_untracked "*"
        end
        if test "$git_ahead" != 0
            set git_str " $git_ahead"
        end
        prompt_transition $git_color white
        echo -n $branch $git_untracked $git_str
    end

    # current jobs
    set -l current_jobs (jobs | grep -v /usr/bin/fish | wc -l | tr -d '[:space:]')
    if [ "$current_jobs" != 0 ]
        prompt_transition red white
        echo -n $current_jobs
    end

    prompt_close
end

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

# chips: the fish plugin manager. https://github.com/kinoru/chips
if [ -e ~/.config/chips/build.fish ] ; source ~/.config/chips/build.fish ; end
alias chipsedit "v ~/.config/chips/plugin.yaml"

# aliases
alias u "unbreak open"
alias v "vim --servername (random)"

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

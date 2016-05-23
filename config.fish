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
function fish_prompt
    # set tmux window name
    if [ $TMUX ]
        prompt_long_pwd | xargs -0 basename | sed -e "s| |\\\\ |g" | xargs tmux rename-window
    end
    if test "$PYENV_VIRTUAL_ENV";
        set_color -b black; set_color white;
        echo -n ' '(basename $PYENV_VIRTUAL_ENV)' ';
        set_color -b blue; set_color black; echo -n '';
    end
    echo -n (set_color -b blue)(set_color white) (hostname) (set_color -b 9CF)(set_color blue)''(set_color black) (prompt_long_pwd) ''
    set git_color 9CF
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
            set git_color cyan
        end
        set -l git_ahead (git rev-list origin/master.. 2> /dev/null | wc -l | tr -d '[:space:]')
        if test "$git_ahead" != 0
            set git_ahead " $git_ahead "
        else
            set git_ahead ""
        end
        echo -n (set_color -b "$git_color")(set_color 9CF)''(set_color white) $branch $git_ahead(set_color normal)
    end
    set -l current_jobs (jobs | grep -v /usr/bin/fish | wc -l | tr -d '[:space:]')
    if [ "$current_jobs" = 0 ]
        echo -n (set_color -b normal)(set_color "$git_color")' '
    else
        echo -n (set_color -b red)(set_color "$git_color")''(set_color white) "$current_jobs" (set_color -b normal)(set_color red)' '
    end
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
alias v "vim"
alias package "v ~/.../arch/list_of_packages"

# Directory-based pyenv-virtualenv
function _pyenv-virtualenv
    if [ -e .pyenv-virtualenv ]
        [ (cat .pyenv-virtualenv) = (basename "$PYENV_VIRTUAL_ENV") ]
        or pyenv activate (cat .pyenv-virtualenv) ^ /dev/null > /dev/null
    else
        [ "$PYENV_VIRTUAL_ENV" = '' ]
        or pyenv deactivate
    end
end

function cd
    builtin cd $argv
    _pyenv-virtualenv
end

_pyenv-virtualenv

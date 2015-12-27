# Path to Oh My Fish install.
set -gx OMF_PATH $HOME/.local/share/omf

# Customize Oh My Fish configuration path.
#set -gx OMF_CONFIG $HOME/.config/omf

# Load oh-my-fish configuration.
if test -e $OMF_PATH/init.fish
    source $OMF_PATH/init.fish
end

set fish_greeting
function prompt_long_pwd --description 'Print the current working directory'
    echo $PWD | sed -e "s|^$HOME|~|"
end
function fish_prompt
    # set tmux window name
    if [ $TMUX ]
        echo $PWD | sed -e "s|^$HOME|~|" | xargs -0 basename | sed -e "s| |\\\\ |g" | xargs tmux rename-window
    end
    echo -n (set_color -b 9CF)(set_color black) (prompt_long_pwd) ''
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
        set -l git_ahead (git rev-list origin/master.. 2> /dev/null | wc -l)
        if test "$git_ahead" != 0
            set git_ahead " $git_ahead "
        else
            set git_ahead ""
        end
        echo -n (set_color -b "$git_color")(set_color 9CF)''(set_color white) $branch $git_ahead(set_color normal)
    end
    set -l current_jobs (jobs | wc -l)
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

if [ -n "$SSH_AGENT_PID" ]
else
    if not pgrep ssh-agent > /dev/null
        ssh-agent -c > ~/..ssh-agent
    end
    eval (head -n 2 ~/..ssh-agent)
end

set PATH $HOME/.cabal/bin $PATH
set PATH $HOME/.local/bin $PATH
# for p in (find $HOME/.apps/**/bin | ag /bin\$)
#     set PATH $p $PATH
# end

alias apt-get "apt-get --no-install-recommends"
alias u "unbreak open"
set TERM xterm-256color

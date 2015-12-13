set fish_greeting
function prompt_long_pwd --description 'Print the current working directory'
    echo $PWD | sed -e "s|^$HOME|~|"
end
function fish_prompt
    # set tmux window name
    if [ $TMUX ]
        echo $PWD | sed -e "s|^$HOME|~|" | xargs basename | xargs tmux rename-window
    end
    set_color -b blue
    set_color white
    echo -n '' (hostname) ''
    set_color -b 9CF
    set_color blue
    echo -n ''
    set_color -b 9CF
    set_color black
    echo -n '' (prompt_long_pwd) ''
    if [ (jobs | wc -l) = 0 ]
        set_color -b normal
        set_color 9CF
        echo -n ' '
        set_color normal
    else
        set_color -b red
        set_color 9CF
        echo -n ''
        set_color white
        echo -n '' (jobs | wc -l) ''
        set_color -b normal
        set_color red
        echo -n ' '
        set_color normal
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
set TERM xterm-256color

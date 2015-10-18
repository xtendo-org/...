set fish_greeting
function prompt_long_pwd --description 'Print the current working directory'
    echo $PWD | sed -e "s|^$HOME|~|"
end
function fish_prompt
    set_color -b blue
    set_color white
    echo -n (prompt_long_pwd) ''
    set_color -b normal
    set_color blue
    echo -n ' '
    set_color normal
end

set PATH $HOME/.cabal/bin $PATH
set PATH $HOME/.local/bin $PATH
for p in (find $HOME/.apps/**/bin | ag /bin\$)
    set PATH $p $PATH
end

alias apt-get "apt-get --no-install-recommends"

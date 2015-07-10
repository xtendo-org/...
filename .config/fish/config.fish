set fish_greeting
function prompt_long_pwd --description 'Print the current working directory'
    echo $PWD | sed -e "s|^$HOME|~|"
end
function fish_prompt
    set_color $fish_color_cwd
    echo -n (prompt_long_pwd)
    set_color normal
    echo ' > '
end

set PATH $HOME/code/ghc/bin $PATH
set PATH $HOME/.cabal/bin $PATH
for p in (find $HOME/.apps/**/bin | ag /bin\$)
    set PATH $p $PATH
end

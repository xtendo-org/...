if not set -q FISH_INITIALIZED
    echo "sourcing once.fish..."
    source ~/.../once.fish
    set -x FISH_INITIALIZED 1
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

# pyenv
function pyenv
  set command $argv[1]
  set -e argv[1]

  switch "$command"
  case activate deactivate rehash shell
    source (pyenv "sh-$command" $argv|psub)
  case '*'
    command pyenv "$command" $argv
  end
end
function _pyenv_virtualenv_hook --on-event fish_prompt;
  set -l ret $status
  if [ -n "$VIRTUAL_ENV" ]
    pyenv activate --quiet; or pyenv deactivate --quiet; or true
  else
    pyenv activate --quiet; or true
  end
  return $ret
end

# Directory-based pyenv-virtualenv
function _pyenv-virtualenv
  command pyenv rehash 2>/dev/null
  if [ -e .pyenv-virtualenv ]
    [ (cat .pyenv-virtualenv) = (basename "$PYENV_VIRTUAL_ENV") ]
    or pyenv activate --quiet (cat .pyenv-virtualenv)
  else
    [ "$PYENV_VIRTUAL_ENV" = '' ]
    or pyenv deactivate
  end
end

_pyenv-virtualenv

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
    autojump --add (pwd) >/dev/null 2>>$AUTOJUMP_ERROR_PATH &
end

# Change Ctrl+w to delete up to the last whitespace;
# use Alt+Backspace for deleting path components.
bind \cw backward-kill-bigword

# autojump
function __aj_err
    # TODO(ting|#247): set error file location
    echo -e $argv 1>&2; false
end
function j
    switch "$argv"
        case '-*' '--*'
            autojump $argv
        case '*'
            set -l output (autojump $argv)
            # Check for . and attempt a regular cd
            if [ $output = "." ]
                cd $argv
            else
                if test -d "$output"
                    set_color red
                    echo $output
                    set_color normal
                    cd $output
                else
                    __aj_err "autojump: directory '"$argv"' not found"
                    __aj_err "\n$output\n"
                    __aj_err "Try `autojump --help` for more information."
                end
            end
    end
end

alias chipsedit "v ~/.config/chips/plugin.yaml"

# chips
if [ -e ~/.config/chips/build.fish ] ; . ~/.config/chips/build.fish ; end

if not set -q FISH_INITIALIZED
    echo "sourcing once.fish..."
    source ~/.../once.fish
    set -x FISH_INITIALIZED 1
end

# aliases
alias v "vim"
function vs
    if [ -e Session.vim ]
      # vim --servername (head --bytes 32 /dev/urandom | b2sum | head -c 32) -S
        vim --servername (pwd) -S
    else
        vim --servername (pwd) -c ':Obsession'
    end
end
alias pyctags "ctags -R --fields=+l --languages=python --python-kinds=-iv -f ./tags . (python -c \"import os, sys; print('\n'.join('{}'.format(d) for d in sys.path if os.path.isdir(d)))\")"

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

# Directory-based pyenv-virtualenv
function _pyenv-virtualenv
  # command pyenv rehash 2>/dev/null
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
        set -l maybe_pwd "$PWD"
        set maybe_pwd (basename (echo $maybe_pwd | sed -E -e "s|^$HOME/(work\|code)/([^/]*)/.*|\2|") | sed -e "s|^mindism-frontend-||" -e "s|^mindism-||")
        # set maybe_pwd (basename $maybe_pwd)
        tmux rename-window $maybe_pwd
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

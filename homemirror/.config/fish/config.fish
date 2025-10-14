if not status is-interactive
    exit
end

if not set -q FISH_INITIALIZED
    source ~/.../once.fish
    set -x FISH_INITIALIZED 1
end

set -q FISH_HOSTNAME || set FISH_HOSTNAME (string shorten -m12 (hostname))

# aliases
alias v "nvim"
function vs
    if [ -e Session.vim ]
      # vim --servername (head --bytes 32 /dev/urandom | b2sum | head -c 32) -S
        vim --servername (pwd) -S
    else
        vim --servername (pwd) -c ':Obsession'
    end
end

# aliases
function nvs
    set -l OBSESSION_PATH "$HOME/.local/share/xtendo.org/vim/session/$(pwd_concise | base64).vim"
    if [ -e $OBSESSION_PATH ]
        nvim -S $OBSESSION_PATH
    else
        nvim -c ":Obsession $OBSESSION_PATH"
    end
end

function __check_pwd --on-variable PWD --description 'PWD change hook'
    status --is-command-substitution; and return
    # set tmux window name
    if [ $TMUX ]
        set -l maybe_pwd "$PWD"
        set maybe_pwd (basename (echo $maybe_pwd | sed -E -e "s|^$HOME/(work\|code)/([^/]*)/.*|\2|") | sed -e "s|^prex-||")
        # set maybe_pwd (basename $maybe_pwd)
        tmux rename-window $maybe_pwd
    end

    autojump --add (pwd) >/dev/null 2>>~/autojump.log &
end

# Change Ctrl+w to delete up to the last whitespace;
# use Alt+Backspace for deleting path components.
bind \cw backward-kill-token
bind alt-backspace backward-kill-word

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

function snipe
  set -l _ps (ps aux | string split0)
  echo $_ps | rg $argv[1] | fzf | awk '{print $2}' | xargs kill
end

function snipe9
  set -l _ps (ps aux | string split0)
  echo $_ps | rg $argv[1] | fzf | awk '{print $2}' | xargs kill -9
end

alias chipsedit "v ~/.config/chips/plugin.yaml"

# chips
if [ -e ~/.config/chips/build.fish ] ; . ~/.config/chips/build.fish ; end

bind \e\[25~ ' '
bind \e\[29~ ' '

function conda --inherit-variable CONDA_EXE
    if [ (count $argv) -lt 1 ]
        $CONDA_EXE
    else
        set -l cmd $argv[1]
        set -e argv[1]
        switch $cmd
            case activate deactivate
                eval ($CONDA_EXE shell.fish $cmd $argv)
            case install update upgrade remove uninstall
                $CONDA_EXE $cmd $argv
                and eval ($CONDA_EXE shell.fish reactivate)
            case '*'
                $CONDA_EXE $cmd $argv
        end
    end
end

# eza
abbr --add --global -- ez 'eza --color=always --icons=always --group-directories-first'

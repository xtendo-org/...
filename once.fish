set -x fish_greeting

# set ssh-agent
if [ -z $SSH_AUTH_SOCK ]
    if not pgrep ssh-agent > /dev/null
        ssh-agent -c | head -n 2 | source
    else
        set -x SSH_AUTH_SOCK (ls /tmp/ssh-*/agent.*)
    end
end

set -x PATH $HOME/.local/bin $PATH
set -x PATH $HOME/.../bin $PATH
# for p in (find $HOME/.apps/**/bin | ag /bin\$)
#     set PATH $p $PATH
# end
set PNPM_PACKAGES "$HOME/.pnpm-packages"
set PATH $PATH $PNPM_PACKAGES/bin

set -gx PNPM_HOME "/home/user/.local/share/pnpm"
set -gx PATH "$PNPM_HOME" $PATH

set -gx FISH_HOSTNAME (string shorten -m12 (hostname))

# pyenv
if [ -d ~/.pyenv ]
    set -gx PATH $HOME"/.pyenv/bin" $PATH
    # . (pyenv init -|psub)
    # status --is-interactive; and source (pyenv virtualenv-init -|psub)
    status --is-interactive; and pyenv init - | source
    status --is-interactive; and pyenv virtualenv-init - | source
end

# rbenv
if [ -d ~/.rbenv ]
    set -x PATH $HOME"/.rbenv/bin" $PATH
    . (rbenv init -|psub)
end

# # autojump
# [ -f /usr/share/autojump/autojump.fish ]; and source /usr/share/autojump/autojump.fish

# cargo
set -x PATH $HOME/.cargo/bin $PATH

# fzf to use ripgrep
set -x FZF_DEFAULT_COMMAND 'rg --files --hidden --follow --glob "!.git/*"'

set -x ARDUINO_PATH /usr/local/arduino

set -x LS_COLORS $LS_COLORS'ow=97;40'

set -x PATH "/opt/flutter/bin" $PATH

# set -Ux PYENV_ROOT $HOME/.pyenv
# set -U fish_user_paths $PYENV_ROOT/bin $fish_user_paths

# status is-login; and pyenv init --path | source
# pyenv init - | source

set -gx PYENV_VIRTUALENV_DISABLE_PROMPT 1

if [ -d ~/.ghcup ]
    set -x PATH $HOME"/.ghcup/bin" $PATH
end

# aliases
function nvs
    if [ -e Session.vim ]
      # vim --servername (head --bytes 32 /dev/urandom | b2sum | head -c 32) -S
        nvim --servername (pwd) -S
    else
        nvim --servername (pwd) -c ':Obsession'
    end
end

# >>> conda initialize >>>

set -gx CONDA_EXE "/opt/miniconda3/bin/conda"
set _CONDA_ROOT "/opt/miniconda3"
set _CONDA_EXE "/opt/miniconda3/bin/conda"
set -gx CONDA_PYTHON_EXE "/opt/miniconda3/bin/python"
# Copyright (C) 2012 Anaconda, Inc
# SPDX-License-Identifier: BSD-3-Clause
#
# INSTALL
#
#     Run 'conda init fish' and restart your shell.
#

if not set -q CONDA_SHLVL
    set -gx CONDA_SHLVL 0
    set -g _CONDA_ROOT (dirname (dirname $CONDA_EXE))
    set -gx PATH $_CONDA_ROOT/condabin $PATH
end

function __conda_add_prompt
    if set -q CONDA_PROMPT_MODIFIER
        set_color -o green
        echo -n $CONDA_PROMPT_MODIFIER
        set_color normal
    end
end

function return_last_status
    return $argv
end




# Autocompletions below


# Faster but less tested (?)
function __fish_conda_commands
    string replace -r '.*_([a-z]+)\.py$' '$1' $_CONDA_ROOT/lib/python*/site-packages/conda/cli/main_*.py
    for f in $_CONDA_ROOT/bin/conda-*
        if test -x "$f" -a ! -d "$f"
            string replace -r '^.*/conda-' '' "$f"
        end
    end
    echo activate
    echo deactivate
end

function __fish_conda_env_commands
    string replace -r '.*_([a-z]+)\.py$' '$1' $_CONDA_ROOT/lib/python*/site-packages/conda_env/cli/main_*.py
end

function __fish_conda_envs
    conda config --json --show envs_dirs | python -c "import json, os, sys; from os.path import isdir, join; print('\n'.join(d for ed in json.load(sys.stdin)['envs_dirs'] if isdir(ed) for d in os.listdir(ed) if isdir(join(ed, d))))"
end

function __fish_conda_packages
    conda list | awk 'NR > 3 {print $1}'
end

function __fish_conda_needs_command
    set cmd (commandline -opc)
    if [ (count $cmd) -eq 1 -a $cmd[1] = conda ]
        return 0
    end
    return 1
end

function __fish_conda_using_command
    set cmd (commandline -opc)
    if [ (count $cmd) -gt 1 ]
        if [ $argv[1] = $cmd[2] ]
            return 0
        end
    end
    return 1
end

# Conda commands
complete -f -c conda -n __fish_conda_needs_command -a '(__fish_conda_commands)'
complete -f -c conda -n '__fish_conda_using_command env' -a '(__fish_conda_env_commands)'

# Commands that need environment as parameter
complete -f -c conda -n '__fish_conda_using_command activate' -a '(__fish_conda_envs)'

# Commands that need package as parameter
complete -f -c conda -n '__fish_conda_using_command remove' -a '(__fish_conda_packages)'
complete -f -c conda -n '__fish_conda_using_command uninstall' -a '(__fish_conda_packages)'
complete -f -c conda -n '__fish_conda_using_command upgrade' -a '(__fish_conda_packages)'
complete -f -c conda -n '__fish_conda_using_command update' -a '(__fish_conda_packages)'

# <<< conda initialize <<<

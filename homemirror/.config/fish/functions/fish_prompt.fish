# set -g tartar_construct ""
# set -g tartar_bg "blue"

function tartar_prompt_transition
    # argv 1: new background color
    # argv 2: new foreground color
    set -g tartar_construct "$tartar_construct "(set_color -b $argv[1])(set_color $tartar_bg)\uE0B0(set_color $argv[2])" "
    set -g tartar_bg $argv[1]
end

function fish_prompt
  if [ $status != 0 ]
    echo (set_color -b red)(set_color white) $status": "$history[1]
  end

  set -g tartar_bg "black"
  set -g tartar_construct (set_color -b black)(set_color white) (echo $PWD | sed -e "s|^$HOME|~|" -e "s|^~/code/||" -e "s|^~/work/||" -e "s|^~/corp/mindism/dev/||" -e "s|^pace-frontend-||" -e "s|^pace-||")

  # pyenv-virtualenv
  if [ $PYENV_VIRTUAL_ENV ];
    tartar_prompt_transition magenta white
    set -g tartar_construct "$tartar_construct"(basename $PYENV_VIRTUAL_ENV)
  end

  # git
  set -f git_dir (git rev-parse --git-dir 2> /dev/null)
  if test -n "$git_dir"
    set -f branch (git branch 2> /dev/null | grep -e '\* ' | sed 's/^..\(.*\)/\1/')
    if test "$branch" = "main"
      set -f branch ''
    end
    set -f git_status (git status -s 2> /dev/null | grep -v "^??")
    if test -n "$git_status"
      set -f git_color yellow
    else
      set -f git_color green
    end
    set -f git_ahead (git rev-list origin/main.. 2> /dev/null | wc -l | tr -d '[:space:]')
    if git status -s 2> /dev/null | grep -q "^??"
      set -f git_untracked " +"
    end
    if [ "$git_ahead" != 0 ]
      set -f git_str "  $git_ahead"
    end
    set -f git_stash (git stash list | wc -l)
    if [ $git_stash = 0 ]
      set -f git_stash
    else
      set -f git_stash " $git_stash"
    end

    tartar_prompt_transition $git_color white
    set -g tartar_construct "$tartar_construct$git_stash$branch$git_untracked$git_str"

  end

  set -l current_jobs (jobs | grep -v /usr/bin/fish | grep -v autojump | wc -l | tr -d '[:space:]')
  if [ "$current_jobs" != 0 ]
    tartar_prompt_transition red white
    set -g tartar_construct "$tartar_construct$current_jobs"
  end

  echo -n "$tartar_construct "(set_color -b normal)(set_color $tartar_bg)\uE0B0(set_color normal)" "

end

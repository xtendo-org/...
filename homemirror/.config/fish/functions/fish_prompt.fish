function fish_prompt
  set -l previous $status
  if [ $previous != 0 ]
    echo -n (set_color -b red -o white)" $previous "(set_color normal)" "
  end
  echo \
    (set_color -b blue white)$CMD_DURATION(set_color normal)\
    (set_color -o cyan)$FISH_HOSTNAME':'(set_color normal)\
    (if [ $PYENV_VERSION ]; echo (set_color -b blue brwhite)$PYENV_VERSION(set_color normal); end)\
    (if [ $CONDA_DEFAULT_ENV ]; echo (set_color -b green brwhite)$CONDA_DEFAULT_ENV(set_color normal); end)\
    (set_color -o blue)(pwd | sed -e "s|^$HOME/work/prex-||" -e "s|^$HOME/code/||" -e "s|^$HOME/work/||" -e "s|^$HOME/||" -e "s|^$HOME|~|")(set_color normal)\
    (if set -l tartar_gitrev (git rev-parse --is-inside-work-tree --abbrev-ref HEAD 2>/dev/null)
      git diff-index --quiet HEAD; and set -l tartar_gitbg green; or set -l tartar_gitbg yellow
      echo -n (set_color -b $tartar_gitbg brwhite)$tartar_gitrev[2]
      set -l tartar_untracked_count (string trim (git ls-files --others --exclude-standard | wc -l))
      if [ $tartar_untracked_count != 0 ]
        echo -n '+'$tartar_untracked_count
      end
      set -l tartar_stash_count (string trim (git stash list | wc -l))
      if [ $tartar_stash_count != 0 ]
        echo -n '#'$tartar_stash_count
      end
      set_color normal
    end)\
    '$ '
end

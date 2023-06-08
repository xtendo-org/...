function fish_prompt
  set previous $status
  set timestamp (string split @ (date +%Y-%m-%d"@"%H:%M:%S"@".%N))
  if [ $previous != 0 ]
    echo -n (set_color -b red -o white)" $previous "(set_color normal)" "
  end
  echo (set_color -b blue white)$CMD_DURATION(set_color normal) (set_color -o green)$timestamp[1](set_color white)T(set_color blue)$timestamp[2](set_color white)$timestamp[3](if [ $PYENV_VERSION ]; echo " "(set_color -b magenta brwhite)$PYENV_VERSION(set_color normal); else; echo ""; end)
  echo (set_color -o blue)(pwd | sed -e "s|^$HOME/work/prex-||" -e "s|^$HOME/code/||" -e "s|^$HOME/work/||" -e "s|^$HOME/||" -e "s|^$HOME|~|")(set_color normal)'$ '
end

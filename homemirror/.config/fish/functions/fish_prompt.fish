function fish_prompt
  set previous $status
  if [ $previous != 0 ]
    echo -n (set_color -b red)(set_color -o white)" $previous "(set_color normal)" "
  end
  echo (set_color -b green)(set_color -o brwhite)(date +%Y-%m-%d" "%H:%M:%S" ".%N) '('$CMD_DURATION')'
  echo -n (set_color normal)(set_color -o blue)(pwd | sed -e 's|^/home/user/mountpoints/relvm/workspace/prex-||' -e 's|^/home/user/mountpoints/relvm|%|' -e 's|^/home/user/code/||' -e 's|^/home/user/||' -e 's|^/home/user|~|')(set_color normal)'$ '
end

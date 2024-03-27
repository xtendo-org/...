#!/bin/bash
history_path="/tmp/tmux.history"
if [ ! -f $history_path ]; then
  echo "$history_path does not exist"
  exit -1
fi
time_str=$(date --iso-8601=ns)
log_path="$HOME/log/tmux/$time_str.log"
mv $history_path $log_path
echo $log_path | xclip -sel clip

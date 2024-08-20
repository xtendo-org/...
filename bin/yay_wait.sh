while true; do
    processes=$(ps aux)

    echo "$processes" | grep 'yay ' && date --iso-8601=ns && echo 'yay is running' || systemctl poweroff

    sleep 1
done

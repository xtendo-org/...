#!/bin/bash
yt-dlp --proxy socks5://@127.0.0.1:50080/ "https://rule34.xxx/index.php?page=post&s=view&id=$1" -o "rule34_$1.%(ext)s"

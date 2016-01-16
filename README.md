Welcome to Kinoru's configuration madness!

Pesky copyright probably does not even apply to these files. Browse and cherry-pick whatever you want.

Notable ones:

- `config.fish`
- `.vimrc`
- `.tmux.conf`

All three of them are configured to the Powerline style.

## Docker

The `Dockerfile` describes my development environment, along with `install.sh`.

```bash
docker build -t kinoru/dev .
docker run -d --name test_sshd -v /home/user/code:/home/user/code -v /home/user/Package:/home/user/package -v /home/user/...:/home/user/... -v /home/user/.vim:/home/user/.vim -h dev kinoru/dev
```

Clean up:

```bash
docker ps -a | sed 1d |  awk '{print $1}' | xargs docker r
```

## Fullscreen title bar

In my compiz configuration, fullscreen title bar is a useless waste of space. A very hacky solution is:

```
sudo vim /usr/share/themes/<Theme name here>/metacity-1/metacity-theme-1.xml
```

Under the `<frame_geometry>` section

- Add attribute `has_title="false"`.
- Set all distance values to 0.

## Windows

Sometimes I have to (grudgingly) use Windows. Links below are for such occasions:

- <http://www.randyrants.com/sharpkeys11.msi>

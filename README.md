Welcome to Kinoru's configuration madness!

Pesky copyright probably does not even apply to these files. Browse and cherry-pick whatever you want.

Note for my future self:

- `install.sh`: Minimum configuration. Sufficient for development (virtual) machines.
- `desktop.sh`: Additional and crazy configuration for Debian/Ubuntu desktops.

I use the text triumvirate of fish, vim, and tmux. All three of them are configured to adapt the Powerline style. [The style for tmux written by Klutzy](https://github.com/klutzy/.../blob/master/.tmux.conf) is minimal yet awesome.

## Docker

The `Dockerfile` describes my development environment.

```bash
docker build -t kinoru/dev .
docker run -t -i -p 9999:22 -p 8001:8000 kinoru/dev /bin/bash
```

Restarting:

```bash
docker stop container_name
docker commit container_name test01
docker run -t -i -p 9999:22 test01 /usr/bin/zsh
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

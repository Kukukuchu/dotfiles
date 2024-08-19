function fixwslg
    if test ! -L /tmp/.X11-unix -o "$(ls -la /tmp/.X11-unix | head | choose -1)" != /mnt/wslg/.X11-unix
        sudo rm -rf /tmp/.X11-unix
        ln -s /mnt/wslg/.X11-unix /tmp/.X11-unix
    end
    ls /tmp/.X11-unix
end

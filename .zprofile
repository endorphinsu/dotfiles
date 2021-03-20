clear
chmod u+x ~/.cache/wal/colors-tty.sh
~/.cache/wal/colors-tty.sh
echo "Welcome $USER"
sleep 1
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && startx

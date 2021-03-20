#!/usr/bin/env bash

source ~/.config/settings

function popup {
	# Plays a "pop" sound
	canberra-gtk-play -i audio-volume-change &
}

# ────────────────────────────────────────────────────────────

function screenshot {

echo $1

case $1 in
        full)
	maim -u -m 1 -d $2 $screendir/latest.png
	;;
        select)
        maim -u -m 1 -s $screendir/latest.png
	;;
esac

if [ $? == "0" ]; then
	cp $screendir/latest.png $screendir/$(date '+%Y-%m-%d-%H:%M:%S').png
	xclip -t image/png -selection clipboard $screendir/latest.png
#	feh ~/Pictures/Screenshots/latest.png
fi

popup

}

# ────────────────────────────────────────────────────────────

function res {

rm ~/.config/resources
echo font=$(grep 'font=' ~/.config/settings | sed 's/^[^=]*=//g') >> ~/.config/resources
echo "background="$(grep background ~/.Xresources | head -n1 | sed 's/^[^#]* //g') >> ~/.config/resources
echo "foreground="$(grep foreground ~/.Xresources | head -n1 | sed 's/^[^#]* //g') >> ~/.config/resources

for i in `seq 0 15`;
do
        color=$(grep color$i ~/.Xresources | head -n1 | sed 's/^[^#]* //g')
        echo "color$i="$color >> ~/.config/resources
done

}

# ────────────────────────────────────────────────────────────

function rice {

# Get fresh colors
wal -i $walldir/$wall
cp ~/.cache/wal/colors.Xresources ~/.Xresources
res

# Get them as variables
source $resfile

pywalfox update

# Applications with pywal as a depend
#pywal-discord -t default
#pywalfox update

sleep 1

sed -i 's/SPACING=3/SPACING=3/g' ~/.cache/wal/colors-oomox

if [ "$1" == "skip" ]; then
echo "Theme creation skipped"
else
# Make themes
/opt/oomox/plugins/icons_papirus/change_color.sh -o "Icon" ~/.cache/wal/colors-oomox
/opt/oomox/plugins/theme_oomox/change_color.sh -m gtk320 -o "Theme" ~/.cache/wal/colors-oomox
fi

# Print colors
wal --preview

rest

}

# ────────────────────────────────────────────────────────────

function rest {

KILL=(
'polybar'
'picom'
)

for KILLING in "${KILL[@]}"; do
killall -q "$KILLING"
while pgrep -u $UID -x "$KILLING" > /dev/null 2>&1; do sleep 0.1; done
done

# Start programs
polybar --quiet --reload --config='~/.config/polybar/config.ini' bar & > /dev/null 2>&1

picom -b --experimental-backends --config ~/.config/picom/picom.conf &

}

# ────────────────────────────────────────────────────────────

function menu {

option1=""
option2=""

chosen=$(echo -en "$option1\n$option2" | $menu)

        case $chosen in
                $option1)
                powermenu
                ;;
                $option2)
                redshiftmenu
                ;;
        esac

}

# ────────────────────────────────────────────────────────────

function powermenu {

option1=""
option2=""
option3=""
option4=""
option5=""

chosen=$(echo -en "$option1\n$option2\n$option3\n$option4\n$option5" | $menu)

        case $chosen in
                $option1)
                poweroff
                ;;
                $option2)
                reboot
                ;;
                $option3)
                i3-msg restart
                ;;
                $option4)
                loginctl terminate-session $XDG_SESSION_ID
                ;;
                $option5)
		xautolock -locknow
                ;;
        esac
}

# ────────────────────────────────────────────────────────────

function redshiftmenu {

option1=""
option2=""

chosen=$(echo -en "$option1\n$option2\n" | $menu)

        case $chosen in
                $option1)
                redshift -P -O 2500
                ;;
                $option2)
                redshift -P -O 6500
                ;;
        esac
}

# ────────────────────────────────────────────────────────────

function backup {

# Deleted i3 config accidentally?
# i3-msg -t get_config > ~/.config/i3/config

source ~/.config/settings

if [ -d $backupdir ]; then
rm -rf $backupdir/*
else
mkdir $backupdir
fi

cp ~/.config/Todo $backupdir

cp -rpu ~/.config/i3/ $backupdir
cp -rpu ~/.config/scripts/ $backupdir
cp -rpu ~/.config/neofetch/ $backupdir
cp -rpu ~/.config/picom/ $backupdir
cp -rpu ~/.config/htop $backupdir
cp -rpu ~/.config/mpd/ $backupdir
cp -rpu ~/.config/ncmpcpp/ $backupdir
cp -rpu ~/.config/picom/ $backupdir
cp -rpu ~/.config/paru/ $backupdir
cp -rpu ~/.config/wal/ $backupdir
cp -rpu ~/.config/nvim/ $backupdir
cp -rpu ~/.config/mpv/ $backupdir
cp -rpu ~/.config/ranger/ $backupdir
cp -rpu ~/.config/rofi/ $backupdir
cp -rpu ~/.config/gtk-3.0/ $backupdir
cp -rpu ~/.config/kitty/ $backupdir
cp -rpu ~/.config/ncmpcpp/ $backupdir
cp -rpu ~/.config/StardewValley/ $backupdir
cp -rpu ~/.config/BetterDiscord/ $backupdir
cp -rpu ~/.config/polybar/ $backupdir

cp ~/.zshrc $backupdir
cp ~/.zprofile $backupdir
cp ~/.config/settings $backupdir
cp ~/.config/mimeapps.list $backupdir

if [ -w ~/.config/Todo ]; then

cp $backupdir/Todo ~/.config

cp -rpu $backupdir/i3/ ~/.config
cp -rpu $backupdir/scripts/ ~/.config
cp -rpu $backupdir/neofetch/ ~/.config
cp -rpu $backupdir/picom/ ~/.config
cp -rpu $backupdir/htop ~/.config
cp -rpu $backupdir/mpd/ ~/.config
cp -rpu $backupdir/ncmpcpp/ ~/.config
cp -rpu $backupdir/picom/ ~/.config
cp -rpu $backupdir/paru/ ~/.config
cp -rpu $backupdir/wal/ ~/.config
cp -rpu $backupdir/nvim/ ~/.config
cp -rpu $backupdir/mpv/ ~/.config
cp -rpu $backupdir/ranger/ ~/.config
cp -rpu $backupdir/rofi/ ~/.config
cp -rpu $backupdir/gtk-3.0/ ~/.config
cp -rpu $backupdir/kitty/ ~/.config
cp -rpu $backupdir/ncmpcpp/ ~/.config
cp -rpu $backupdir/StardewValley/ ~/.config
cp -rpu $backupdir/BetterDiscord/ ~/.config
cp -rpu $backupdir/polybar/ ~/.config

cp $backupdir/.zshrc ~/.config
cp $backupdir/.zprofile ~/.config
cp $backupdir/settings ~/.config
cp $backupdir/mimeapps.list $backupdir

fi

}

# ────────────────────────────────────────────────────────────

function lock {

xautolock -detectsleep -locker '~/.config/scripts/functions.sh locker'

}

# ────────────────────────────────────────────────────────────

function locker {

# Fix this mess (someday)

i3lock -c "#292D3E00" --redraw-thread -e \
--insidevercolor=292D3E10 --insidewrongcolor=292D3E00 --insidecolor=292D3E25 \
--ringvercolor=292D3E00 --ringwrongcolor=ff0000 --ringcolor=292D3E25 \
--greetertext="" --wrongtext="" --veriftext="" --noinputtext="" \
--greetercolor=ffffff --timecolor=ffffff --wrongcolor=ffffff --verifcolor=ffffff --layoutcolor=ffffff \
--radius 200 --linecolor=292D3E25 --ring-width 15 -B 1 \
--greeter-font='FantasqueSansMono Nerd Font Mono' \
--verif-font='FantasqueSansMono Nerd Font Mono' \
--wrong-font='FantasqueSansMono Nerd Font Mono' \
--layout-font='FantasqueSansMono Nerd Font Mono' \
--date-font='FantasqueSansMono Nerd Font Mono' \
--greetersize=128 --timesize=64 --datesize=128 \
--layoutsize=128 --wrongsize=128 --verifsize=128

}

# ────────────────────────────────────────────────────────────

case $1 in
	kbmap)
        kbmap
	;;
	screenshot)
	screenshot $2 $3
	;;
	res)
	res
	;;
	rice)
	rice $2
	;;
	rest)
	rest
	;;
	backup)
	backup
	;;
	lock)
	lock
	;;
	locker)
	locker
	;;
	menu)
	menu
	;;
	powermenu)
	powermenu
	;;
	redshiftmenu)
	redshiftmenu
	;;
esac

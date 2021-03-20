# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/u/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

kitty + complete setup zsh | source /dev/stdin

# Remove % on newlines
PROMPT_EOL_MARK=''

source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

typeset -g POWERLEVEL9K_INSTANT_PROMPT=off

# ────────────────────────────────────────────────────────────

# v to inverse and A to put to playlist
# c to clear the playlist

# Useful commands
# Put single quotes when downlaod music and videos
alias video-dl="youtube-dl --add-metadata -i --output '~/Videos/%(title)s.%(ext)s'"
alias music-dl="youtube-dl -x --add-metadata --output '~/Music/%(title)s.%(ext)s' --audio-quality 0 -i --audio-format flac "
alias fonts="fc-list | sed 's/:.*//'"

# Colors
alias ls="ls --color"
alias grep='grep --color=auto'

# Scripts
alias rice="~/.config/scripts/functions.sh rice"
alias code="~/.config/scripts/code.sh"
alias server="echo 'connect tms-server.com:28015' | xclip -selection clipboard"
alias audio="systemctl restart --user pipewire && systemctl restart --user pipewire.socket && systemctl restart --user pipewire-pulse && systemctl restart --user pipewire-pulse.socket && mpd --kill && mpd && ~/.config/scripts/functions.sh rest"

alias :q="exit"

alias vim="nvim"
alias yay="paru"

# emacs mode
bindkey -e

# bindkey -v

# ────────────────────────────────────────────────────────────

function mksh {

if [ -w $1 ]; then
echo "This file already exists"
exit 0
else
echo "Creating file..."
touch $1

chmod u+x $1

echo -e '#!/usr/bin/env bash\n' >> $1
echo 'echo "Hello World!"' >> $1
nvim $1
fi

}

# ────────────────────────────────────────────────────────────

function setwall {

source ~/.config/settings
var=$(ls $walldir | fzf --color 16 --ansi --layout=reverse)

if [ -n "$var" ] && [ -e $walldir/$var ]; then
sed -i "s/^wall=.*/wall=$var/g" ~/.config/settings
~/.config/scripts/functions.sh rice $1
fi

}

#
# ~/.bashrc
#

[[ $- != *i* ]] && return

## Colors

blue=$(tput setaf 014);
white=$(tput setaf 255);
bold=$(tput bold);
reset=$(tput sgr0);

## Prompt
PS1="\[${blue}\]\[${bold}\]["      # Blue [
PS1+="\[${white}\]\u"                                 # Working Directory
PS1+="\[${blue}\]] "     # Blue ]
# PS1+="\[${blue}\]\[${bold}\]["      # Blue [
PS1+="\[${white}\]\w"                                 # Working Directory
# PS1+="\[${blue}\]]"     # Blue ]
PS1+="\[${white}\] ➤ \[${reset}\]"
export PS1

alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias grub-update='grub-mkconfig -o /boot/grub/grub.cfg'
alias update=$HOME/dotfiles/scripts/update.sh
alias sudo='sudo -E'
alias protontricks='flatpak run com.github.Matoking.protontricks'
alias penpot-stop=$HOME/Documents/penpot/penpot-stop.sh
alias v="nvim"
alias tm="tmux attach"

xhost +local:root > /dev/null 2>&1

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.  #65623
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize

shopt -s expand_aliases

# export QT_SELECT=4

# Enable history appending instead of overwriting.  #139609
shopt -s histappend

export VISUAL="vim"
export EDITOR="vim"
export PATH="$HOME/.local/bin:$PATH"

# asdf - version control
if ! command -v asdf &> /dev/null
then
    . $HOME/.config/asdf/asdf.sh
    . $HOME/.config/asdf/completions/asdf.bash
else
    :
fi

if ! command -v cargo &> /dev/null; then
    . "$HOME/.cargo/env"
else
    :
fi

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
PS1+="\[${white}\]\u@\H"                                 # Working Directory
PS1+="\[${blue}\]]"     # Blue ]
PS1+="\[${blue}\]\[${bold}\]["      # Blue [
PS1+="\[${white}\]\w"                                 # Working Directory
PS1+="\[${blue}\]]"     # Blue ]
PS1+="\[${white}\] ➤ \[${reset}\]"
export PS1

alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias np='nano -w PKGBUILD'
alias more=less
alias grub-update='grub-mkconfig -o /boot/grub/grub.cfg'
alias updata=$HOME/dotfiles/update.sh

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

#
# # ex - archive extractor
# # usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

export VISUAL="vim"
export EDITOR="vim"
export PATH="$HOME/.local/bin:$PATH"


# asdf
. $HOME/.config/asdf/asdf.sh
. $HOME/.config/asdf/completions/asdf.bash

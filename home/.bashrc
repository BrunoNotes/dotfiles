# ~/.bashrc

[[ $- != *i* ]] && return

## Colors

blue=$(tput setaf 014);
white=$(tput setaf 255);
bold=$(tput bold);
reset=$(tput sgr0);

## Prompt
PS1=""
PS1+=" \[${white}\]\w"                                 # Working Directory
PS1+="\[${white}\] \[${reset}\]"
export PS1

## Alias
alias cp="cp -i"                                                # Confirm before overwriting something
alias df="df -h"                                                # Human-readable sizes
alias free="free -m"                                            # Show sizes in MB
alias ll="ls -al"
alias sudo="sudo -E"
alias tm="tmux a"
alias grub-update="grub-mkconfig -o /boot/grub/grub.cfg"
alias gs="lazygit" # git status

## Scripts
alias update="$HOME/dotfiles/scripts/update.sh"
alias bkp_sync="$HOME/dotfiles/pc_config/bash/backup.sh"
alias snvim="$HOME/dotfiles/scripts/nvim_server.sh"
alias note="$HOME/dotfiles/scripts/note.sh"

xhost +local:root > /dev/null 2>&1

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.  #65623
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize
shopt -s expand_aliases

# Enable history appending instead of overwriting.  #139609
shopt -s histappend

export VISUAL="vim"
export EDITOR="vim"
# export TERMINAL="alacritty"
export TERMINAL="ghostty"
export PATH="$HOME/.local/bin:$PATH"

# Languages
export PATH="$HOME/.local/local/go/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/.local/lang/zig:$PATH"
export PATH="$HOME/.local/lang/Odin:$PATH"
export PATH="$HOME/.local/share/pnpm:$PATH"
export PATH="$HOME/.deno/bin:$PATH"

export ASPNETCORE_ENVIRONMENT="Development" # csharp

# Ocaml
opam=$(command -v opam || true)
if [[ -n $opam ]]; then
    eval $(opam env)
fi

# Rust
cargo=$(command -v cargo || true)
if [[ -n $cargo ]]; then
    . "$HOME/.cargo/env"
fi

# Vim mode
set -o vi

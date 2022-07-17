#!/bin/bash

export ZDOTDIR=$HOME/.config/zsh
HISTFILE=~/.zhistory
setopt appendhistory

## Options section
setopt autocd extendedglob nomatch menucomplete nobeep

stty stop undef                                                 # Disable ctrl-d to freeze ternubak
zle_highlight=("paste:none")                                    # Disable paste highlight

# completions
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'       # Case insensitive tab completion
zstyle ':completion:*' menu select
zmodload zsh/complist
# compinit
_comp_options+=(globdots)		# Include hidden files.

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# Theming section 
autoload -Uz colors && colors

# Useful Functions
source "$ZDOTDIR/zsh-functions"

# Normal files to source
zsh_add_file "zsh-exports"
zsh_add_file "zsh-vim-mode"
zsh_add_file "zsh-aliases"
zsh_add_file "zsh-prompt"

# Plugins
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"

# Key-bindings
bindkey "^k" up-line-or-beginning-search # Up
bindkey "^j" down-line-or-beginning-search # Down

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
# bindkey '^e' edit-command-line

# Environment variables set everywhere
export VISUAL="vim"
export EDITOR="nvim"
export TERMINAL="alacritty"
export PATH="$HOME/.local/bin:$PATH"

# asdf - version control

if ! command -v asdf &> /dev/null; then
    . $HOME/.config/asdf/asdf.sh
    # append completions to fpath
    fpath=(${ASDF_DIR}/completions $fpath)
else
    :
fi

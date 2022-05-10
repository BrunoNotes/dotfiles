## Options section
setopt nobeep                                                   # No beep
setopt autocd                                                   # if only directory path is entered, cd there.

stty stop undef                                                 # Disable ctrl-d to freeze ternubak

zle_highlight=("paste:none")                                    # Disable paste highlight

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'       # Case insensitive tab completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"         # Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' rehash true                              # automatically find new executables in path 
# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
HISTFILE=~/.zhistory
HISTSIZE=1000
SAVEHIST=1000

## Alias section 
alias cp="cp -i"                                                # Confirm before overwriting something
alias df='df -h'                                                # Human-readable sizes
alias free='free -m'                                            # Show sizes in MB
alias grub-update='grub-mkconfig -o /boot/grub/grub.cfg'
alias ls='exa --icons'
alias update=$HOME/dotfiles/update.sh
alias sudo='sudo -E'

# Theming section  
autoload -U compinit colors zcalc
compinit -d
colors

# Color man pages
export LESS_TERMCAP_mb=$'\E[01;32m'
export LESS_TERMCAP_md=$'\E[01;32m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;47;34m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;36m'
export LESS=-R

## Plugins section: Enable fish style features

# Use syntax highlighting
source ${HOME}/dotfiles/.config/zsh/plugins/zsh-syntax-highlight/zsh-syntax-highlighting.zsh

## Prompt section

# Load version control information
autoload -Uz vcs_info

zstyle ':vcs_info:*' enable git 
precmd() { vcs_info }
setopt prompt_subst

# Check changes in repo
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked 
+vi-git-untracked(){
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
        git status --porcelain | grep '??' &> /dev/null ; then
        # This will show the marker if there are any untracked files in repo.
        hook_com[staged]+='!' # signify new files with a bang
    fi
}
zstyle ':vcs_info:*' check-for-changes true

# Format the vcs_info_msg_0_ variable
# %b - Branch information, like master
# %m - In case of Git, show information about stashes
# %u - Show unstaged changes in the repository
# %c - Show staged changes in the repository
zstyle ':vcs_info:git:*' formats "%F{014}[%f%F{red}%m%u%c%f %F{yellow}%b%f%F{014}]%f"
 
# Set up the prompt (with git branch name)
PROMPT='%B%F{012}[%F{white}%n%F{12}]%f%b'
PROMPT+='%B${vcs_info_msg_0_}%b'                            # Git branch
PROMPT+='%B%F{012}[%f${PWD/#$HOME/~}%F{12}]%f%b'            # Directory
PROMPT+=' %B%F{015}➤%f%b '                                  # Arrow


export VISUAL="vim"
export EDITOR="vim"
export PATH="$HOME/.local/bin:$PATH"

# asdf - version control

. $HOME/.config/asdf/asdf.sh
# append completions to fpath
fpath=(${ASDF_DIR}/completions $fpath)
# initialise completions with ZSH's compinit
autoload -Uz compinit && compinit

# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# User specific environment and startup programs
. "$HOME/.cargo/env"

. "$HOME/.config/asdf/asdf.sh"
. "$HOME/.config/asdf/completions/asdf.bash"

# export PATH="$HOME/.local/go/bin:$PATH"
. "$HOME/.local/go/bin:$PATH"

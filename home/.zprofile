. "$HOME/.cargo/env"

# asdf - version control
. $HOME/.config/asdf/asdf.sh
fpath=(${ASDF_DIR}/completions $fpath)

export PATH="$HOME/.local/go/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"

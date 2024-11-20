# Add deno completions to search path
if [[ ":$FPATH:" != *":/home/bruno/.config/zsh/completions:"* ]]; then export FPATH="/home/bruno/.config/zsh/completions:$FPATH"; fi
# pnpm
export PNPM_HOME="/home/bruno/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

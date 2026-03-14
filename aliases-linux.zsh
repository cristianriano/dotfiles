# Linux-specific aliases and functions

# Docker Compose v2 (installed as a Docker plugin, not standalone binary)
alias docker-compose='docker compose'

# Clipboard support: pbcopy/pbpaste compatible with macOS API
# Uses xclip when DISPLAY is available (local/X11), falls back to OSC 52
# for headless/SSH sessions (works with Ghostty and other modern terminals)
pbcopy() {
  if [ -n "$DISPLAY" ] && command -v xclip &>/dev/null; then
    xclip -selection clipboard
  else
    local content encoded
    content=$(cat)
    encoded=$(printf '%s' "$content" | base64 | tr -d '\n')
    printf "\033]52;c;%s\033\\" "$encoded"
  fi
}

pbpaste() {
  if [ -n "$DISPLAY" ] && command -v xclip &>/dev/null; then
    xclip -selection clipboard -o
  else
    printf "\033]52;c;?\033\\"
  fi
}

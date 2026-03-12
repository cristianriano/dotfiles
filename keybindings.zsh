# Notation
#
# `C-`:   Means pressing down ctrl
# `M-`:   Alt/Option
# `S-`:   Shift
# `^[[A`: Arrow UP
# `^[[B`: Arrow DOWN

# Use emacs-style line editing
# Required for `zsh-shift-select` plugin
bindkey -e

# zsh-shift-select overrides
# Shift + Cmd + Left / Right (macOS sends ;10)
bindkey '^[[1;10D' shift-select::beginning-of-line
bindkey '^[[1;10C' shift-select::end-of-line

# Cmd <-/-> for beginning/end of line
# Alt <-/-> move one word backfward/forward
bindkey '^[b' backward-word
bindkey '^[f' forward-word
bindkey '^[a' beginning-of-line
bindkey '^[e' end-of-line
# Use C-a and C-e as by default in many consoles
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line

# history-substring-search to use UP and DOWN
# ^[[A/^[[B = normal mode (macOS), ^[OA/^[OB = application mode (Linux/SSH terminfo)
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^[OA' history-substring-search-up
bindkey '^[OB' history-substring-search-down
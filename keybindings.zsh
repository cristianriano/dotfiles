# Notation
#
# `C-`:   Means pressing down ctrl 
# `^[[A`: Arrow UP
# `^[[B`: Arrow DOWN

# Cmd <-/-> for beginning/end of line
# Alt <-/-> move one word backfward/forward
bindkey '^[b' backward-word
bindkey '^[f' forward-word
bindkey '^[a' beginning-of-line
bindkey '^[e' end-of-line

# Bind UP and DOWN arrow keys to C-r
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
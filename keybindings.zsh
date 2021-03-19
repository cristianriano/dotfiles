# Notation
#
# `C-`:   Means pressing down ctrl
# `M-`:   Alt/Option
# `S-`:   Shift
# `^[[A`: Arrow UP
# `^[[B`: Arrow DOWN

# Cmd <-/-> for beginning/end of line
# Alt <-/-> move one word backfward/forward
bindkey '^[b' backward-word
bindkey '^[f' forward-word
bindkey '^[a' beginning-of-line
bindkey '^[e' end-of-line
# Use C-a and C-e as by default in many consoles
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line

# ALWAYS sourced. Often contains exported variables that should be available to other programs (e.g $PATH, $EDITOR, and $PAGER)

#
# OS Detection
#
[[ "$OSTYPE" == darwin* ]] && IS_MAC=true || IS_MAC=false
export IS_MAC

#
# Editors
#
export EDITOR=nvim
export VISUAL=code
export PAGER=less

#
# Global ENV
#
# :- if parameter is null or unset substitute, otherwise nothing
# :+ if parameter is null or unset, nothing is substituted, otherwise the expansion is substituted.

# Skip potentially early compinit. Instead handled manually when installing `zsh-completions` in zi-config.zsh
skip_global_compinit=1
export DOTFILES_HOME=${DOTFILES_HOME:-"$HOME/dotfiles"}
export SHELL="${commands[zsh]}"
export ERL_AFLAGS="-kernel shell_history enabled"
export MANPATH="/usr/share/man"

#
# Paths
#
# Set the list of directories that Zsh searches for programs.
if [[ ! -d "$HOME/.local" ]]; then
  mkdir -p "$HOME/.local"
fi

path=(
  /usr/local/{bin,sbin}
  "$HOME/.local/bin"
  $path
)

# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path
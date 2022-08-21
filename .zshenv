# ALWAYS sourced. Often contains exported variables that should be available to other programs (e.g $PATH, $EDITOR, and $PAGER)

#
# Editors
#
export EDITOR=vim
export VISUAL=code
export PAGER=less

#
# Global ENV
#
# :- if parameter is null or unset substitute, otherwise nothing
# :+ if parameter is null or unset, nothing is substituted, otherwise the expansion is substituted.
skip_global_compinit=1
export DOTFILES_HOME=${DOTFILES_HOME:-"$HOME/dotfiles"}
export SHELL='/usr/local/bin/zsh'
export ERL_AFLAGS="-kernel shell_history enabled"

#
# Paths
#
# Set the list of directories that Zsh searches for programs.
path=(
  /usr/local/{bin,sbin}
  $DOTFILES_HOME/bin
  $path
)

# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path
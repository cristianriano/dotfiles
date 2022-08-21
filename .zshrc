# For interactive shells. Set options with setopt and unsetopt commands. Load shell modules, set
# history options, set up completion. Also set variables only used in the interactive shell (e.g. $LS_COLORS).

## History
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000

setopt beep inc_append_history share_history interactivecomments hist_ignore_dups
autoload colors && colors

## Brew config
HOMEBREW_NO_INSTALLED_DEPENDENTS_CHECK=1

## ZI plugins, keybindings, aliases and functions
DOTFILES_HOME=${DOTFILES_HOME:-"$HOME/dotfiles"}
source "$DOTFILES_HOME/aliases.zsh"
source "$DOTFILES_HOME/zi-config.zsh"
source "$DOTFILES_HOME/keybindings.zsh"


export FZF_DEFAULT_OPTS="--no-mouse --height=70% --reverse --multi --cycle --preview='[[ \$(file --mime {}) =~ binary ]] && echo {} is binary || (bat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -100' --preview-window='right:hidden:wrap' --bind='ctrl-u:half-page-up,ctrl-d:half-page-down,f2:toggle-preview'"

export DISABLE_SPRING=true

export RIPGREP_CONFIG_PATH=~/.ripgrep.config

# If only mysql libraries are installed the binaries need to be added explicitly to the PATH
if [[ -d "/usr/local/opt/mysql-client/bin" ]] && ! command -v mysqldump &> /dev/null
  then export PATH="/usr/local/opt/mysql-client/bin":$PATH
fi

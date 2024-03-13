# For interactive shells. Set options with setopt and unsetopt commands. Load shell modules, set
# history options, set up completion. Also set variables only used in the interactive shell (e.g. $LS_COLORS).

## History
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000

setopt beep inc_append_history share_history interactivecomments hist_ignore_dups
autoload colors && colors

## Brew config
# Sets Brew config. Use /opt/homebrew/bin/ for M1 otherwise /usr/local/bin/
eval "$(/opt/homebrew/bin/brew shellenv)"
HOMEBREW_NO_INSTALLED_DEPENDENTS_CHECK=1

## ZI plugins, keybindings, aliases and functions
DOTFILES_HOME=${DOTFILES_HOME:-"$HOME/dotfiles"}
DISABLE_OH_MY_POSH=1
source "$DOTFILES_HOME/aliases.zsh"
source "$DOTFILES_HOME/zi-config.zsh"
source "$DOTFILES_HOME/keybindings.zsh"


export FZF_DEFAULT_OPTS="--no-mouse --height=70% --reverse --multi --cycle --preview='[[ \$(file --mime {}) =~ binary ]] && echo {} is binary || (bat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -100' --preview-window='right:hidden:wrap' --bind='ctrl-u:half-page-up,ctrl-d:half-page-down,f2:toggle-preview'"
# Not working now
export FZF_COMPLETION_TRIGGER='~~'

export DISABLE_SPRING=true

export RIPGREP_CONFIG_PATH=~/.ripgrep.config

# Link keg-only Brew libraries
export PATH="$HOMEBREW_PREFIX/opt/mysql-client/bin:$PATH"

# Docker default Platform (amd64 if M1)
#export DOCKER_DEFAULT_PLATFORM=linux/x86_6
export DOCKER_DEFAULT_PLATFORM=linux/amd64

export ASDF_GOLANG_MOD_VERSION_ENABLED=true

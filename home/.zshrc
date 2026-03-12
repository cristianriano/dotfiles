# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# For interactive shells. Set options with setopt and unsetopt commands. Load shell modules, set
# history options, set up completion. Also set variables only used in the interactive shell (e.g. $LS_COLORS).

## History
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
SQLITE_HISTORY="~/.sqlite_history"

setopt beep inc_append_history share_history interactivecomments hist_ignore_dups
autoload colors && colors

## ZI plugins, keybindings, aliases and functions
source "$DOTFILES_HOME/aliases.zsh"
source "$DOTFILES_HOME/base-zi.zsh"
source "$DOTFILES_HOME/keybindings.zsh"

## macOS customizations
if $IS_MAC; then
  # Sets Brew config. Use /opt/homebrew/bin/ for M1 otherwise /usr/local/bin/
  eval "$(/opt/homebrew/bin/brew shellenv)"

  source "$DOTFILES_HOME/mac-zi.zsh"

  HOMEBREW_NO_INSTALLED_DEPENDENTS_CHECK=1

  # Link keg-only Brew libraries
  export PATH="$HOMEBREW_PREFIX/opt/mysql-client/bin:$PATH"

  # Add iTerm utilities to PATH (imgcat)
  if [[ -d /Applications/iTerm.app/Contents/Resources/utilities ]]; then
    export PATH="/Applications/iTerm.app/Contents/Resources/utilities:$PATH"
  fi
fi

## Linux customizations
if ! $IS_MAC; then
  # Use lightweight vim instead of nvim+LazyVim for quick edits
  alias n="vim"

  # Clipboard support: alias pbcopy/pbpaste so scripts and keybindings work on both OSes
  alias pbcopy='xclip -selection clipboard'
  alias pbpaste='xclip -selection clipboard -o'
fi

export FZF_DEFAULT_OPTS="
--no-mouse
--height=75%
--reverse
--multi
--cycle
--preview-window='right:wrap'
--bind='ctrl-u:half-page-up,ctrl-d:half-page-down,f2:toggle-preview'
--preview='fzf-preview.sh {}'"
export FZF_CTRL_R_OPTS="
  --no-preview
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"
export FZF_ALT_C_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'tree -C {}'"

export DISABLE_SPRING=true
export RIPGREP_CONFIG_PATH=~/.ripgrep.config

# Docker default Platform (arm64 if apple silicon)
#export DOCKER_DEFAULT_PLATFORM=linux/x86_6
#export DOCKER_DEFAULT_PLATFORM=linux/amd64
#export DOCKER_DEFAULT_PLATFORM=linux/arm64

#### asdf config ####
export ASDF_DIR=~/.asdf
export PATH="$ASDF_DIR/shims:$PATH"
export ASDF_GOLANG_MOD_VERSION_ENABLED=true

# Set JAVA_HOME
if [[ -f "$ASDF_DIR/plugins/java/set-java-home.zsh" ]]; then
  source "$HOME/.asdf/plugins/java/set-java-home.zsh"
fi

# Set golang config
if [[ -d "$ASDF_DIR/plugins/golang" ]]; then
  source ${ASDF_DATA_DIR:-$HOME/.asdf}/plugins/golang/set-env.zsh
fi

# Hook direnv into zsh
# &>: Redirect file descriptor 1-2 (STDOUT-STERR, 0 is STDIN) to the file on the other side of operand
if [[ -d "$ASDF_HOME/plugins/direnv" ]]; then
  if command -v direnv &> /dev/null; then
    # Use system managed version
    export ASDF_DIRENV_BIN="$(command -v direnv)"
    eval "$($ASDF_DIRENV_BIN hook zsh)"
  else
    eval "$(asdf exec direnv hook zsh)"
    direnv() { asdf exec direnv "$@"; }
  fi

  [[ ! -f "$HOME/.envrc" ]] && echo 'use asdf' > "$HOME/.envrc"
fi
### end asdf config ###

eval "$(zoxide init zsh --no-cmd)"
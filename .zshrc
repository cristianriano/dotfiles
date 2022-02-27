## History
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
setopt beep
setopt inc_append_history
setopt share_history
autoload colors && colors
setopt interactivecomments # Comments on commands

## Global ENV
export DOTFILES_HOME=${DOTFILES_HOME:-"$HOME/dotfiles"}
export SHELL='/usr/local/bin/zsh'
export ERL_AFLAGS="-kernel shell_history enabled"

## Binaries & Scripts
[[ -d "$DOTFILES_HOME/bin" ]] && export PATH="$DOTFILES_HOME/bin:$PATH"

## ZI plugins
source "$DOTFILES_HOME/zi-config.zsh"

## Keybindings
[[ -f "$DOTFILES_HOME/keybindings.zsh" ]] && source "$DOTFILES_HOME/keybindings.zsh"

## Aliases and functions
[[ -f "$DOTFILES_HOME/aliases.zsh" ]] && source "$DOTFILES_HOME/aliases.zsh"


export FZF_DEFAULT_OPTS="--no-mouse --height=70% --reverse --multi --cycle --preview='[[ \$(file --mime {}) =~ binary ]] && echo {} is binary || (bat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -100' --preview-window='right:hidden:wrap' --bind='ctrl-u:half-page-up,ctrl-d:half-page-down,f2:toggle-preview'"

export DISABLE_SPRING=true

export RIPGREP_CONFIG_PATH=~/.ripgrep.config

# Set JAVA_HOME
if asdf current java &> /dev/null; then
  source "$HOME/.asdf/plugins/java/set-java-home.zsh"
fi

# Hook direnv into zsh
# &>: Redirect file descriptor 1-2 (STDOUT-STERR, 0 is STDIN) to the file on the other side of operand
if command -v direnv &> /dev/null; then
  eval "$(asdf exec direnv hook zsh)"
  direnv() { asdf exec direnv "$@"; }
fi

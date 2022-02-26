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
declare -g DOTFILES_HOME=${DOTFILES_HOME:-"$HOME/dotfiles"}
export SHELL='/usr/local/bin/zsh'
export ERL_AFLAGS="-kernel shell_history enabled"

## Binaries & Scripts
[[ -d "$DOTFILES_HOME/bin" ]] && export PATH="$DOTFILES_HOME/bin:$PATH"

### Load Zinit
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# patch-dl: Download and apply patches. ice: `dl` `patch`
# as-monitor: Auto-download of last version. ice: `as"monitor"`
# bin-gem-node: Executable not on PATH. `fbin` ice
zinit light-mode for \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-bin-gem-node

## Modules
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=1"
zinit ice id-as="autosuggestions"; zinit light zsh-users/zsh-autosuggestions

# Completions
zinit ice wait lucid blockf id-as="zsh-completions" atload"zicompinit; zicdreplay"
zinit light zsh-users/zsh-completions

zinit snippet PZT::modules/completion
zstyle ':completion:*' completer _complete _match _expand

zinit wait lucid light-mode depth=1 for \
  pick="autopair.zsh" atload="autopair-init" hlissner/zsh-autopair \
  pick="async.zsh" mafredri/zsh-async

# Fuzzy Finder package (from Zsh-Packages/fzf)
zinit pack multisrc="shell/*.zsh" depth=1 for fzf

# Fasd
zinit ice as="command" pick="$ZPFX/bin/fasd" make="!PREFIX=$ZPFX install" \
  atclone="mkdir -p $ZPFX/bin; cp -vf fasd $ZPFX/bin" atpull="%atclone" depth=1 \
  atload='eval "$(fasd --init auto)"'
zinit light clvv/fasd

## History search
# ctrl-r
zinit light zdharma/history-search-multi-word
zinit light zsh-users/zsh-history-substring-search

## Version Managers
# Tarball with the bin-gem-node annex-utilizing ice list
# zinit wait"1" lucid pack"bgn" depth=1 for pyenv
# lucid: Removes `loaded` message for async

zinit ice wait lucid depth=1 id-as"asdf" pick"asdf.sh" fpath"completions"
zinit light asdf-vm/asdf

## Theme
# Font
zinit ice id-as"meslo" from"gh-r" as"null" bpick"Meslo.zip" extract depth=1 \
  atclone="rm -f *Windows*; mv -f *.ttf $HOME/Library/Fonts/" atpull"%atclone"
zinit light ryanoasis/nerd-fonts

zinit ice depth=1; zinit load romkatv/powerlevel10k
if [[ ($(ps -p $PPID) =~ 'Visual Studio') && (-f ~/.p10k-lean.zsh) ]] then; source ~/.p10k-lean.zsh
elif [[ -f ~/.p10k.zsh ]] then; source ~/.p10k.zsh
fi

# Syntax highlight must be the last one
zinit ice id-as="fast-highlight" depth=1
zinit light zdharma/fast-syntax-highlighting

autoload -Uz compinit

# Man pages
[[ -d $ZPFX/man ]] && export MANPATH="$ZPFX/man:$MANPATH"

### End Load Zinit

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

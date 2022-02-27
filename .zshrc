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

### Load ZI (https://github.com/z-shell/zi)
export ZI_HOME="${HOME}/.zi"
if [[ ! -f "$ZI_HOME/bin/zi.zsh" ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}Z-SHELL%F{220} A Swiss Army Knife for Zsh (%F{33}z-shell/zi%F{220})…%f"
    command mkdir -p "$ZI_HOME" && command chmod g-rwX "$ZI_HOME"
    command git clone https://github.com/z-shell/zi.git "$ZI_HOME/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$ZI_HOME/bin/zi.zsh"
autoload -Uz _zi
(( ${+_comps} )) && _comps[zi]=_zi

# Annexes (extensions) for ZI. Adds ice modifiers:
#   - patch-dl: Download and apply patches. ice: `dl` `patch`
#   - bin-gem-node: Executable not on PATH. `fbin` ice
zi light-mode for \
    z-shell/z-a-patch-dl \
    z-shell/z-a-bin-gem-node

## Modules
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=1"
zi ice id-as="autosuggestions"; zi light zsh-users/zsh-autosuggestions

# Completions
zi ice wait lucid blockf id-as="zsh-completions" atload"zicompinit; zicdreplay"
zi light zsh-users/zsh-completions

zi snippet PZT::modules/completion
zstyle ':completion:*' completer _complete _match _expand

zi wait lucid light-mode depth=1 for \
  pick="autopair.zsh" atload="autopair-init" hlissner/zsh-autopair \
  pick="async.zsh" mafredri/zsh-async

# Fuzzy Finder package (from Zsh-Packages/fzf)
zi pack multisrc="shell/*.zsh" depth=1 for fzf

# Fasd
zi ice as="command" pick="$ZPFX/bin/fasd" make="!PREFIX=$ZPFX install" \
  atclone="mkdir -p $ZPFX/bin; cp -vf fasd $ZPFX/bin" atpull="%atclone" depth=1 \
  atload='eval "$(fasd --init auto)"'
zi light clvv/fasd

## History search
# ctrl-r
zi light-mode for \
  z-shell/history-search-multi-word \
  zsh-users/zsh-history-substring-search

## Version Managers
# Tarball with the bin-gem-node annex-utilizing ice list
# zi wait"1" lucid pack"bgn" depth=1 for pyenv
# lucid: Removes `loaded` message for async

# atload="!PATH+=:~/share"
zi ice wait lucid depth=1 id-as="asdf" pick="asdf.sh" fpath="completions" atload="!export FOO=bar"
zi light asdf-vm/asdf

## Theme
# Font
zi ice id-as"meslo" from"gh-r" as"null" bpick"Meslo.zip" extract depth=1 \
  atclone="rm -f *Windows*; mv -f *.ttf $HOME/Library/Fonts/" atpull"%atclone"
zi light ryanoasis/nerd-fonts

zi ice depth=1; zi load romkatv/powerlevel10k
if [[ ($(ps -p $PPID) =~ 'Visual Studio') && (-f ~/.p10k-lean.zsh) ]] then; source ~/.p10k-lean.zsh
elif [[ -f ~/.p10k.zsh ]] then; source ~/.p10k.zsh
fi

# Syntax highlight must be the last one
zi ice id-as="fast-highlight" depth=1
zi light z-shell/fast-syntax-highlighting

autoload -Uz compinit

# Man pages
[[ -d $ZPFX/man ]] && export MANPATH="$ZPFX/man:$MANPATH"

### End Load ZI

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

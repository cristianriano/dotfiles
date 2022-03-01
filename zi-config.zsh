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

zi ice as="completion" id-as="docker-completions"
zi snippet https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker

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

# ZI plugin for diff-so-fancy https://github.com/z-shell/zsh-diff-so-fancy
zi ice wait lucid as'program' pick'bin/git-dsf'
zi load z-shell/zsh-diff-so-fancy

## Version Managers
# Tarball with the bin-gem-node annex-utilizing ice list
# zi wait"1" lucid pack"bgn" depth=1 for pyenv
# lucid: Removes `loaded` message for async

## ASDF

function _post_zi_asdf() {
  export ASDF_DIR=${ASDF_DIR:-"$ZI[PLUGINS_DIR]/asdf"}
  export ASDF_HOME=${ASDF_HOME:-"$HOME/.asdf"}

  # Set JAVA_HOME
  if [[ -f "$ASDF_HOME/plugins/java/set-java-home.zsh" ]]; then
    source "$HOME/.asdf/plugins/java/set-java-home.zsh"
  fi

  # Hook direnv into zsh
  # &>: Redirect file descriptor 1-2 (STDOUT-STERR, 0 is STDIN) to the file on the other side of operand
  if [[ -d "$ASDF_HOME/plugins/direnv" ]]; then
    eval "$(asdf exec direnv hook zsh)"
    direnv() { asdf exec direnv "$@"; }

    [[ ! -f "$HOME/.envrc" ]] && echo 'use asdf' > "$HOME/.envrc"
  fi
}

# The commented line configures ASDF adding shims to the PATH. In which case global .envrc is not needed
zi ice wait lucid depth=1 id-as="asdf" pick="lib/asdf.sh" atload='PATH+="!:$ZI_HOME/plugins/asdf/bin/" ; _post_zi_asdf'
# zi ice wait lucid depth=1 id-as="asdf" pick="asdf.sh" atload='!_post_zi_asdf'
zi light asdf-vm/asdf

## END ASDF

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
# Call compinit after load zsh-completions

# Man pages
[[ -d $ZPFX/man ]] && export MANPATH="$ZPFX/man:$MANPATH"

### End Load ZI
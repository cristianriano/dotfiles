### Load ZI (https://github.com/z-shell/zi)
# Docs: https://wiki.zshell.dev/docs/guides/syntax/ice-modifiers

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
zi ice wait lucid blockf atinit"zicompinit; zicdreplay" id-as="zsh-completions"
zi light zsh-users/zsh-completions

zi snippet PZT::modules/completion
zstyle ':completion:*' completer _complete _match _expand

zi wait lucid light-mode depth=1 for \
  pick="autopair.zsh" atload="autopair-init" hlissner/zsh-autopair \
  pick="async.zsh" mafredri/zsh-async

# Binds fzf widgets via `bindkey` (ctrl + T | ctrl + R)
zi snippet https://github.com/junegunn/fzf/blob/master/shell/key-bindings.zsh
# Fzf completion (**<TAB>)
zi ice wait lucid id-as="fzf-completion"
zi snippet https://github.com/junegunn/fzf/blob/master/shell/completion.zsh

## History search
# ctrl-r
zi light-mode for \
  z-shell/H-S-MW \
  zsh-users/zsh-history-substring-search

# Select text in the command line using <Shift> as in many text editors
## Because Terminals intercept Cmd+{c,v,x} it can't copy selected text
## Only works in the kill-ring buffer with ctrl+w and ctrl+y (yank)
zi ice id-as="shift-select"
zi light jirutka/zsh-shift-select

# ZI plugin for diff-so-fancy https://github.com/z-shell/zsh-diff-so-fancy
zi ice wait lucid as'program' pick'bin/git-dsf'
zi load z-shell/zsh-diff-so-fancy

## Theme
# Font
zi ice id-as"meslo" from"gh-r" as"null" bpick"Meslo.zip" extract depth=1 \
  atclone="rm -f *Windows*; mv -f *.ttf $HOME/Library/Fonts/" atpull"%atclone"
zi light ryanoasis/nerd-fonts

# Use either Oh-My-Posh or Powerlevel10k (default) for rendering depending on the Terminal
if [ "$TERM_PROGRAM" = "WarpTerminal" ] && [ "$DISABLE_OH_MY_POSH" != "1" ]; then
  eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh.omp.json)"
  # eval "$(starship init zsh)"
else
  zi ice depth=1; zi load romkatv/powerlevel10k
  # Use full config for suported terminals and lean config for other embeded terminals
  if [[ "$TERM_PROGRAM" =~ ^(ghostty|WarpTerminal|iTerm\.app)$ && -f ~/.p10k.zsh ]]; then
    source ~/.p10k.zsh
  elif [[ -f ~/.p10k-lean.zsh ]]; then
    source ~/.p10k-lean.zsh
  fi
fi

## Version Managers
# Tarball with the bin-gem-node annex-utilizing ice list
# zi wait"1" lucid pack"bgn" depth=1 for pyenv
# lucid: Removes `loaded` message for async

# Syntax highlight must be the last one
zi wait lucid for id-as="fast-highlight" z-shell/F-SY-H

# Man pages
[[ -d $ZPFX/man ]] && export MANPATH="$ZPFX/man:$MANPATH"

### macOS-only ZI plugins: Nerd Font auto-download

# Font
zi ice id-as"meslo" from"gh-r" as"null" bpick"Meslo.zip" extract depth=1 \
  atclone="rm -f *Windows*; mv -f *.ttf $HOME/Library/Fonts/" atpull"%atclone"
zi light ryanoasis/nerd-fonts

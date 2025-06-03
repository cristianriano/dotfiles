# For login shells. Basically the same as .zlogin except that it's sourced BEFORE .zshrc

#
# Sets Brew config. Use /opt/homebrew/bin/ for M1 otherwise /usr/local/bin/
#
eval "$(/opt/homebrew/bin/brew shellenv)"

#
# Browser
#
if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER='open'
fi

#
# Language
#
if [[ -z "$LANG" ]]; then
  export LANG='en_US.UTF-8'
fi

#
# Less
#
# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X and -F (exit if the content fits on one screen) to enable it.
# Add -X to not use an alternate screen
export LESS='-g -i -M -R -S -w -z-4'

# Set the Less input preprocessor.
# Try both `lesspipe` and `lesspipe.sh` as either might exist on a system.
if (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi

# Coloring
export LESS_TERMCAP_mb=$'\e[1;31m'
export LESS_TERMCAP_md=$'\e[1;31m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[1;44;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;32m'

#
# GPG
#
export GPG_TTY=$(tty)

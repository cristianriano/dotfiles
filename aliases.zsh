### Aliases
# Utils
alias ls="ls -G"
alias ll="ls -l -A"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
#alias rm="rm -i"
alias j='fasd_cd -i' # Change dir interactively
# Docker
alias postgres_config="docker create --name postgres -p 5432:5432 -v "/Users/$(whoami)/code/data:/var/lib/postgresql/data" -e POSTGRES_PASSWORD=password postgres:10.6"
alias postgres_start="docker start postgres"
alias dockredis="docker run -d --rm --name redis -p 6379:6379 redis:latest"
# Git
alias g="git"
alias gst="git status"
alias ga="git add"
alias gc="git commit --verbose"
alias gco="git checkout"
alias gd="git diff"
alias glog="git log --oneline --decorate --graph"
alias gb="git branch"
alias gf="git fetch"
alias gp="git push"
alias gs="git stash"
# Bundle
alias bi="bundle install --jobs=4"
alias be="bundle exec"
# Rails
alias rg="bundle exec rails generate"
# Tmux
alias tmuxa="tmux attach"
alias tmuxl="tmux ls"
alias tmuxn="tmux new"
# Fzf
alias fzfx="fzf | xargs"


### Functions
# Dotfiles
declare -ga dotfiles=(.gemrc .vimrc .zshrc .zprofile .zlogin .tmux.conf .p10k.zsh .p10k-lean.zsh .pryrc .gitignore .gitconfig .gitattributes .asdfrc .gitmessage)

function dotfiles_link () {
  for file in $dotfiles; do ln -f -s $DOTFILES_HOME/$file $HOME/$file; done
}
function dotfiles_unlink () {
  for file in $dotfiles
  do
    local file_path="$HOME/$file"
    if [[ -h $file_path ]] then; unlink $file_path
    elif [[ -f $file_path ]] then; rm -f $file_path
    fi
  done
}


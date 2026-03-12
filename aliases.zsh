### Aliases
# Utils
alias ls="ls -G --color=auto"
alias ll="ls -hl -A --color=auto"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
#alias cat="bat"
alias n="nvim"
# Docker
alias postgres_config='docker create --name postgres -p 5432:5432 -v "$HOME/code/volumes:/var/lib/postgresql/data" -e POSTGRES_PASSWORD=password POSTGRES_HOST_AUTH_METHOD=trust postgres:10.6'
alias dockredis='docker run -d --rm --name redis -p 6379:6379 -v "$HOME/code/volumes/redis:/data" redis:latest'
alias dockpostgres11='docker run -d --rm --name postgres11 -p 5432:5432 -v "$HOME/code/data11:/var/lib/postgresql/data" -e POSTGRES_PASSWORD=password -e POSTGRES_HOST_AUTH_METHOD=trust postgres:11'
alias dockmysql57='docker run -d --rm --name mysql57 -p 3307:3306 -v "$HOME/code/volumes/mysql:/var/lib/mysql" -e MYSQL_ROOT_PASSWORD=password mysql:5.7'
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
alias gsw="git switch"
# Bundle
alias bi="bundle install --jobs=4"
alias be="bundle exec"
# Rails
#alias rg="bundle exec rails generate"
# Tmux
alias tmuxa="tmux attach"
alias tmuxl="tmux ls"
alias tmuxn="tmux new"
# Fzf
alias fzfx="fzf | xargs"
# Zoxide (define alias manually otherwise they collide with zshell pkg manager)
alias z='__zoxide_z'
alias zz='__zoxide_zi'
# K8S
alias k="kubectl"

### Functions
# Dotfiles
DOTFILES_HOME=${DOTFILES_HOME:-"$HOME/dotfiles"}

dotfiles_link() {
  for file in "$DOTFILES_HOME"/home/.*; do
    [[ "$(basename "$file")" == "." || "$(basename "$file")" == ".." ]] && continue
    ln -sfn "$file" "$HOME/$(basename "$file")"
  done

  ln -sfn "$DOTFILES_HOME/.gitignore" "$HOME/.gitignore"

  mkdir -p "$HOME/.local/bin"
  for file in "$DOTFILES_HOME"/.local/bin/*; do
    ln -sfn "$file" "$HOME/.local/bin/$(basename "$file")"
  done
}

dotfiles_unlink() {
  for file in "$DOTFILES_HOME"/home/.*; do
    [[ "$(basename "$file")" == "." || "$(basename "$file")" == ".." ]] && continue
    local file_path="$HOME/$(basename "$file")"
    [[ -h "$file_path" ]] && unlink "$file_path"
  done

  [[ -h "$HOME/.gitignore" ]] && unlink "$HOME/.gitignore"

  for file in "$DOTFILES_HOME"/.local/bin/*; do
    local file_path="$HOME/.local/bin/$(basename "$file")"
    [[ -h "$file_path" ]] && unlink "$file_path"
  done
}

# Config folder
config_link() {
  local src_dir="$DOTFILES_HOME/.config"
  local dst_dir="$HOME/.config"

  mkdir -p "$dst_dir"

  for s in "$src_dir"/*; do
    name="$(basename "$s")"
    ln -sfn "$s" "$dst_dir/$name"
  done
}

# Agent skills
skills_link() {
  skills_path="$HOME/.agents/skills"
  if [[ ! -d $skills_path ]]; then
    echo "$skills_path not found"
    return 1
  fi

  [[ -d "$HOME/.claude" ]] && ln -sfn $HOME/.agents/settings.json $HOME/.claude/settings.json

  for s in "$skills_path"/*; do
    name="$(basename "$s")"

    # Add any other Agents here
    [[ -d "$HOME/.claude" ]] && ln -sfn $s "$HOME/.claude/skills/$name"
    [[ -d "$HOME/.codex" ]] && ln -sfn $s "$HOME/.codex/skills/$name"
  done
}

# Time Zshell loading time
timezsh() {
  shell=${1-$SHELL}
  for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
}

# Force myself to use rg instead of grep
grep() {
  if [ -t 1 ]; then  # Only print the warning if stdout is a terminal
    echo "⚠️  WARNING: Use 'rg' (ripgrep) instead 'grep' for faster searches.\n\n" >&2
  fi
  command grep "$@"
}

# Interactive file picker using fzf. As the default keybinding ctrl-t can't be used in Warp
ff() {
  local files

  # (@) expands into element arrays
  # (f) split on \n
  files=("${(@f)$(fzf)}") || return

  # Quote each path safely and join with spaces
  # (q) quotes each element safely
  print -z -- "${(q)files[@]}"
}

# Interactive git branch switcher using fzf
gg() {
  local branch
  branch=$(git branch | grep -v '/HEAD' | sed 's/^[* ]*//' | fzf --height 40% --preview 'git log -5 --oneline {}') || return
  git checkout "$branch"
}

printp() {
  echo $PATH | tr ':' '\n'
}

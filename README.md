# Dotfiles

This repo is a collection of my dotfiles and configurations for zsh, tmux, nvim, git and some custom scripts.
It's meant to be used in a Mac. A limited version is available for [Linux](#linux-ubuntu-server)

Workspace uses [Ghostty](https://ghostty.org/) terminal, [Powerlevel10k](https://github.com/romkatv/powerlevel10k)
theme and [zi from zshell](https://wiki.zshell.dev/) plugin manager for shell behaviour.

Files it provides:

- aliases.zsh (custom aliases and functions)
- base-zi.zsh (core ZI plugins, loaded on all OSes)
- mac-zi.zsh (macOS-only: Nerd Font + Powerlevel10k theme)
- keybindings.zsh
- .p10k.zsh and .p10k-lean.zsh (full and lite config for theme)
- .asdfrc and .default-\* (for asdf config and plugins)
- Brewfile (binaries and system resources)
- Global .gitattributes, .gitconfig and .gitignore
- Ruby's .gemrc, .pryrc
- Elixir's .iex.exs
- .sqliterc (sqlite3)
- .tmux.conf
- nvim config
- Zsh configs (in execution orderder)
  - .zshenv
  - .zprofile
  - .zshrc
  - .zlogin

## Installation

1. Install [Brew](https://brew.sh/) (This will also install dev tools if missing e.g `git`)
2. Create a new ssh-key `ssh-keygen -t rsa -C "<email>" -b 4096` and add it as your default identity `ssh-add ~/.ssh/id_rsa`
3. Clone the repo `git clone https://github.com/cristianriano/dotfiles.git ~/dotfiles`
4. Run `source aliases.zsh` and then the functions `dotfiles_link` and `config_link` on the shell
5. Run `brew bundle` inside the repo (check commented dependencies if needed)
6. [OPTIONAL] Set `zsh` as the default shell `chsh -s /bin/zsh`
7. Open a new terminal, it should download `zi` and install the packages (you might have to do it multiple times)
8. Open `nvim` to install [LazyVim](https://www.lazyvim.org/) (install lua > 5.1 first)

## TODOs

Things to improve or at least consider and make a decision (in no particular order)

- Install fonts via Brew (`font-meslo-lg-nerd-font`) instead of zi. Fonts are a system resource not shell specific. (Update README too)
- Update `zi` installation to use new standard https://wiki.zshell.dev/docs/getting_started/installation
- Link all `.*` files for the dotfiles_link function to avoid mantaining a `dotfiles` var

## Terminals

This setup supports multiple terminals. Below is a section for each.

All terminals needs a Nerd font that allows icons & glyphs in the prompt.

This setup uses `MesloLGM Nerd Font` which is downloaded automatically and saved in `~/Library/Fonts/`
by ZI the first time zhell is started.

If the Font is not detected by the system copy+paste them in the _Font Book_

### Ghostty

Configuration in `.config/ghostty/config` is picked up by default.

### Warp

Change the following _Settings_:

1. Set the `Meslo` Font _Appearance > Text > Terminal Font_
2. Set Input to classic. Go to _Appearance > Input > Classic_
3. Dim inactive panes _Appearance > Panes > Dim inactive_
4. Change themes _Appearance > Themes_

- Sync with OS
- Solarized Dark & Light

#### Known Issues

Because Warp wraps each execution in a block, many plugins for zshell do not work properly. The ones I confirm:

- zsh-autopair: Auto pair/delete delimiters
- fzf bindings: Ctrl+T to select multiple files
- [powerlevel10k "show on command"](https://github.com/romkatv/powerlevel10k?tab=readme-ov-file#show-on-command)

### iTerm2

To import the settings:

1. Go to _Settings > General > Settings_
2. Check the `Load settings from a custom folder or URL` option
3. Select the path where this repo was cloned, it will automatically pick the `com.googlecode.iterm2.plist` file
4. Restart iTerm2

## Shell

This setup depends on `zsh` shell. It manages configuration via some files and relays on [ZI](https://z-shell.pages.dev/) from zshell heavily.

### ZI

[ZI](https://z-shell.pages.dev/) is used for loading plugins, leverages Turbo mode to decrease loading speed
(run `timezsh` to measure zsh initialization 10 times).

List packages and delete them with `zi list` and `zi delete <name>`

To update and compile it run\
`zi self-update`

#### Packages list

- [Autosuggestions Fish style](https://github.com/zsh-users/zsh-autosuggestions)
- [Additional completions for zsh](https://github.com/zsh-users/zsh-completions)
- [Select text in the command line using <Shift>](https://github.com/jirutka/zsh-shift-select)
- [Prezto completions](https://github.com/sorin-ionescu/prezto/tree/master/modules/completion)
- [Auto pair/delete delimiters](https://github.com/hlissner/zsh-autopair)
- [ASDF - Version Manager](https://github.com/asdf-vm/asdf)
- [History search multi world](https://github.com/z-shell/history-search-multi-word)
- [History substring search](https://github.com/zsh-users/zsh-history-substring-search)
- [Fast Highlighting](https://github.com/z-shell/fast-syntax-highlighting)
- [diff-so-fancy](https://github.com/so-fancy/diff-so-fancy)
- [Power 10K theme](https://github.com/romkatv/powerlevel10k)

## Other Configurations

### Keyboard

#### Change between Desktops

Keyboard settings > Shortcuts > Mission Control

1. Move left a space -> Ctrl-Cmd-Left
2. Disable Ctrl-Up and Ctrl-Down

#### Key repetition

Keyboard settings > Keyboard

1. Key repeat -> Fast
2. Delay Until repeat -> Short

#### Disable conflicting shortcuts

Keyboard settings > Shortcuts

1. Services > Text

- Search man page index in Terminal (Cmd+Shift+A)

2. Mission Control

- Mission Control
- Application Window

### Apps

#### BetterSnapTool

Installed from Appstore ([homepage](https://folivora.ai/bettersnaptool))
Used for window management. Set the shortcuts for:

- Left half: Cmd+Alt+Ctrl+Left
- Right half: Cmd+Alt+Ctrl+Right
- Maximize: Cmd+Alt+Ctrl+M
- Maximize on next monitor: Cmd+Alt+Ctrl+Up

### Vim

Lightweight Vim setup using [vim-plug](https://github.com/junegunn/vim-plug) with TokyoNight Storm theme.

Plugins auto-install on first launch. To manually install: `:PlugInstall`

Plugins:

- [NERDTree](https://github.com/preservim/nerdtree) — File explorer sidebar
- [fzf](https://github.com/junegunn/fzf) — Fuzzy file finder
- [vim-signify](https://github.com/mhinz/vim-signify) — Git diff signs in the gutter
- [vim-multiple-cursors](https://github.com/terryma/vim-multiple-cursors) — Sublime-style multiple selections
- [vim-sensible](https://github.com/tpope/vim-sensible) — Universal sensible defaults
- [rainbow_csv](https://github.com/mechatroner/rainbow_csv) — Highlight CSV columns in different colors
- [TokyoNight](https://github.com/ghifarit53/tokyonight-vim) — Color scheme (storm variant)

## Cheatsheet

### Elixir

Installing Elixir requires Erlang too. We will use `asdf` to be able to have multiple versions.

Elixir versioning have `x.y.z-otp-w`, this is a pre-compiled version for W major Erlang version. The
version without `otp` is that compiled against the oldest OTP release supported by that version. We
will go with the precompiled version of the major Erlang supported.

1. Install dependencies with brew (table below). The only recommended one is `wxmac` to run the observer.
   Use `brew install --build-from-source wxmac`
2. Install the latest Erlang compatible with the Elixir version you want `asdf install erlang x.y`
   (Optional: Install documentation for Erlang modules with `KERL_BUILD_DOCS=yes` used in iex)\
   **NOTE: When installing OTP < 25 set export KERL_CONFIGURE_OPTIONS="--with-ssl=$(brew --prefix openssl) --without-javac"**
3. Install elixir precompiled version for the Erlang chosen

| Dependency | Required? | Why install?                                |
| ---------- | --------- | ------------------------------------------- |
| fop        | 🚫        | Only for building PDF docs                  |
| unixodbc   | 🚫        | Only if you use ODBC                        |
| openjdk    | 🚫        | Already have JDK; optional for Java interop |
| wxmac      | 🔶        | Optional but recommended for :observer      |

### Direnv

Direnv loads env variables when navigating to a folder with `.envrc`

There is also a [plugin](https://github.com/asdf-community/asdf-direnv) with `asdf` to avoid the roundtrip to the shims. To enable it in a parent folder\
`echo 'use asdf' > .envrc`

And then allow the execution by running\
`direnv allow`

### Ruby

- Generate a UUID on the fly\
  `ruby -r securerandom -e 'puts SecureRandom.uuid'`

### Go

- Install package from source\
  `go install github.com/mikefarah/yq/v4@latest`

### Tmux

- New session\
  `tmux new -s work`

- Attach
  `tmux attach -t work`

### Git

- List configuration\
  `git config --list --show-origin`

- Rubocop Prehook

```
touch .git/hooks/pre-commit
chmod +x .git/hooks/pre-commit
git diff --diff-filter AM --name-only --staged | grep "\.rb$" | xargs bundle exec rubocop --parallel --disable-pending-cops
```

### Docker

- Run auto-cleaned container command\
  `docker run -it --rm ubuntu /bin/bash`

- Buildx and tag
  `docker buildx build --tag mytag:1.0 --build-arg key=value --ssh default .`

- Buld with custom cache
  `docker buildx build --tag mytag:1.0 --file Dockerfile --cache-from=type=local,src=/tmp/.buildx-cache --cache-to=type=local,dest=/tmp/.buildx-cache .`

## Linux (Ubuntu Server)

This setup also works on Linux (tested on Ubuntu). The config detects the OS via `IS_MAC` (set in `.zshenv`) and adjusts automatically.

### Prerequisites

Install these manually (no Brewfile equivalent):

```bash
sudo apt install zsh zoxide fzf ripgrep diff-so-fancy xclip
```

### What works differently

- **Clipboard** — `pbcopy`/`pbpaste` are aliased to `xclip` so fzf's ctrl-y and other scripts work
- **Homebrew paths** — skipped entirely (mysql-client, iTerm utilities, etc.)
- **Nerd Font** — not downloaded. The SSH client's font is what matters on a headless server

## Known Issues

### Global versions not detected

If direnv is not creating the executable to the correct versions defined in `.tool-versions` then run `direnv reload`

### Installing Erlang 24

When installing Erlang 24 you get a message error about crypto library like this:

> checking for OpenSSL in /usr/local/opt/openssl@1.1... configure: error: neither static nor dynamic crypto library found in /usr/local/opt/openssl@1.1

[Solution](https://youtu.be/w7JkhGrjnMY?t=94)

### Compinit error messages

```
rm ~/.zcompdump* && compinit
```

## Screenshots

![Warp](./screenshots/warp.png)

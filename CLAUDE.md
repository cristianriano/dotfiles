# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

Personal dotfiles repository managing shell configuration, terminal settings, editor config, and development tools via symlinks. Used on macOS (personal + work) and Ubuntu server. Primary terminal is Ghostty, shell is ZSH with ZI plugin manager.

## Key Architecture

### Multi-OS Support

- **`IS_MAC`** env var (set in `.zshenv` via `$OSTYPE`) drives OS-conditional logic
- Base config is shared across macOS and Linux
- macOS-specific customizations are layered on top (kustomize-style)
- Linux gets clipboard compatibility aliases (`pbcopy`/`pbpaste` → `xclip`)

### File Organization

- **Root dotfiles**: Traditional dotfiles (.zshrc, .gitconfig, .tmux.conf, etc.) - linked via `dotfiles_link`
- **.config/**: XDG Base Directory compliant configs (nvim, ghostty, direnv, starship) - linked via `config_link`
- **Custom ZSH modules** (sourced in .zshrc):
  - `aliases.zsh` - Custom aliases and shell functions
  - `base-zi.zsh` - ZI plugin manager: core plugins loaded on all OSes
  - `mac-zi.zsh` - ZI macOS layer: Nerd Font download
  - `keybindings.zsh` - Keybindings (emacs-style line editing)

### Shell Loading Order

1. `.zshenv` - Environment variables for all shells (sets `IS_MAC`)
2. `.zprofile` - Login shell setup
3. `.zshrc` - Interactive shell configuration (sources custom modules above)
4. `.zlogin` - Post-initialization for login shells

### ZI Plugin Manager

Uses turbo mode for lazy loading plugins to optimize shell startup. Plugins include:

- zsh-autosuggestions, zsh-completions, zsh-autopair
- fzf keybindings (ctrl-t, ctrl-r) and completion
- zsh-shift-select (visual text selection with shift)
- history-search-multi-word, zsh-history-substring-search
- fast-syntax-highlighting
- Powerlevel10k theme
- **macOS only**: MesloLGM Nerd Font auto-downloaded to ~/Library/Fonts/

### Version Management

- **asdf**: Multi-language version manager configured via `.asdfrc`
- **Default packages**: `.default-gems`, `.default-python-packages`, `.default-golang-pkgs`, `.default-mix-commands`
- **direnv**: Auto-loads environment variables from `.envrc`, integrated with asdf via `.config/direnv/direnvrc`

### Neovim

Uses LazyVim framework. Configuration in `.config/nvim/` with lua files for options, keymaps, autocmds, and plugins.

## Common Commands

### Initial Setup

```bash
# After cloning repo, symlink dotfiles and config directories
source aliases.zsh
dotfiles_link  # Links root dotfiles to $HOME
config_link    # Links .config/* to $HOME/.config/

# macOS: Install all dependencies
brew bundle

# Linux: Install manually (zsh, fzf, ripgrep, zoxide, diff-so-fancy, xclip)

# ZI will auto-install on first zsh launch, or manually:
zi self-update
```

### Managing Dotfiles

```bash
# Add/remove symlinks
dotfiles_link      # Create symlinks for all dotfiles
dotfiles_unlink    # Remove symlinks for all dotfiles
config_link        # Create symlinks for .config/ files

# Test what files would be linked
declare -a dotfiles  # See aliases.zsh:48 for current list
```

### ZI Plugin Management

```bash
zi list              # List installed plugins
zi delete <name>     # Remove a plugin
zi self-update       # Update ZI itself
timezsh              # Benchmark zsh startup time (runs 10 times)
```

### Shell Utilities

```bash
ff                   # Interactive file picker with fzf (outputs to command line)
gg                   # Interactive git branch switcher with preview
printp               # Print PATH with each entry on new line
```

### Language Runtime Management (asdf)

```bash
asdf install <plugin> <version>   # Install specific version
asdf set <plugin> <version>       # Set project-local version (.tool-versions)

# Direnv integration for faster shim-less execution
echo 'use asdf' > .envrc
direnv allow
```

### FZF Configuration

Custom FZF options set in .zshrc:

- Preview window on right with `fzf-preview.sh` script
- F2 to toggle preview
- Ctrl-u/d for half-page scroll
- Ctrl-y in history search copies command to clipboard

## File Modifications

### Adding New Dotfiles

1. Add file to `$DOTFILES_HOME/` directory
2. Add filename to `dotfiles` array in `aliases.zsh:48`
3. Run `dotfiles_link` to create symlink

### Adding ZI Plugins

Add to `base-zi.zsh` (cross-platform) or `mac-zi.zsh` (macOS-only) using appropriate loading strategy:

- `zi light` - Simple load
- `zi ice wait lucid` - Turbo mode (lazy load)
- `zi snippet` - Load single file (e.g., from GitHub)

### Modifying Terminal Config

- **Ghostty**: Edit `.config/ghostty/config`
- **Powerlevel10k configs** (macOS only):
  - Full config (`.p10k.zsh`): Used by Ghostty, Warp, and iTerm2
  - Lean config (`.p10k-lean.zsh`): Default for all other terminals (VSCode, IntelliJ, Codex, etc.)
  - Logic in `mac-zi.zsh` checks `$TERM_PROGRAM` to determine which config to load

## Terminal-Specific Behavior

Warp Terminal has compatibility issues with:

- zsh-autopair
- fzf ctrl-t keybinding (use `ff` function instead)
- Powerlevel10k "show on command" feature

## Important Conventions

- **IS_MAC** env var set in `.zshenv` — use `if $IS_MAC` for OS-conditional logic
- **DOTFILES_HOME** env var defaults to `$HOME/dotfiles`
- All symlinks should point to repo, not copy files
- Use `rg` (ripgrep) instead of grep - config in `.ripgrep.config`
- `grep` command wrapper prints warning to prefer `rg`
- FZF preview script: `fzf-preview.sh` (should exist in PATH via .local/bin)

# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository that manages development environment configurations using GNU Stow for symlink management. The repository is organized into separate directories for each configuration area.

## Setup and Installation

### Automated Installation
```bash
./install.sh
```

The install script performs:
1. Verifies macOS and Homebrew installation
2. Installs packages from Brewfile
3. Installs oh-my-zsh (if not present)
4. Backs up existing dotfiles (creates .backup.TIMESTAMP files)
5. Creates symlinks using GNU Stow
6. Installs mise tools
7. Changes default shell to zsh

### Manual Installation
```bash
# Install all packages and applications
brew bundle --file brew/Brewfile

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Create symlinks for specific configurations
stow -t ~/ zsh      # Install zsh configuration
stow -t ~/ git      # Install git configuration
stow -t ~/ mise     # Install mise configuration
stow -t ~/ claude   # Install claude configuration

# Install mise tools
mise install
```

### Package Management
- Homebrew packages, casks, and VS Code extensions are defined in `.brew/Brewfile`
- Use `brew bundle --file .brew/Brewfile` to install or update packages

## Repository Structure

The repository uses GNU Stow's directory structure pattern:
- Each top-level directory (zsh, git, mise, claude) represents a "stow package"
- Files within these directories mirror the target location structure (typically `~/`)
- Running `stow -t ~/ <package>` creates symlinks from `~/` to files in the package directory

### Configuration Areas

**zsh/** - Zsh shell configuration
- `.zshrc`: Main zsh configuration with oh-my-zsh setup
  - Theme: robbyrussell
  - Plugins: git, fzf, mise
  - Environment: EDITOR=vim, LANG=ja_JP.UTF-8
- `.oh-my-zsh/custom/custom.zsh`: Custom functions and aliases
  - `repo`: Navigate to repositories using fzf
  - `clone`: Clone and navigate using ghq
  - `kclone`: Clone kamina-zzz repositories
  - Auto-execute `ll` after `cd`
  - Loads `~/.local.zsh` if present for machine-specific settings

**git/** - Git configuration
- `.gitconfig`: Git settings
  - User: kamina.dev1991@gmail.com / kamina-zzz
  - GHQ root: ~/src/

**mise/** - Mise (runtime version manager) configuration
- `.config/mise/config.toml`: Tool versions
  - node: 22
  - usage: latest

**claude/** - Claude Code configuration
- `.claude/settings.json`: Claude Code settings
  - Vertex AI integration enabled
  - Custom completion sound/notification on stop
  - Extended bash timeout: 300s default, 1200s max

## Development Workflow

### Working with Dotfiles

When modifying configurations:
1. Edit files in the appropriate directory (zsh/, git/, etc.)
2. Changes are immediately reflected in the home directory via symlinks
3. Commit changes to track configuration history

### Adding New Tools

To add new packages:
1. Add to `.brew/Brewfile` under appropriate section (brew/cask/vscode)
2. Run `brew bundle --file .brew/Brewfile` to install
3. Add configuration files in appropriate directory if needed
4. Use `stow` to create symlinks if new configuration directory is added

### Repository Management

This repository uses ghq for repository management:
- Repositories are cloned to `~/src/` (ghq root)
- Use `clone <repo-url>` to clone and navigate
- Use `repo` to fuzzy-find and navigate to existing repositories
- Use `kclone <repo-name>` for kamina-zzz repositories

## Key Tools and Commands

- **stow**: Symlink management (`stow -t ~/ <package>`)
- **brew**: Package management (`brew bundle --file brew/Brewfile`)
- **ghq**: Repository management (configured to use `~/src/`)
- **fzf**: Fuzzy finder (used in custom functions)
- **mise**: Runtime version manager (manages node, etc.)
- **oh-my-zsh**: Zsh framework with plugins
- to memorize
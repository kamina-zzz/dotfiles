# dotfiles

## Installation

```bash
./install.sh
```

This script will:
1. Install all packages from `.brew/Brewfile`
2. Install oh-my-zsh
3. Create symlinks using GNU Stow for all configuration packages (zsh, git, mise, starship, gh, wezterm, tmux, cmux, ghostty)
4. Install mise tools
5. Change default shell to zsh

## Manual Installation

If you prefer to install manually:

```bash
# Install packages
brew bundle --file .brew/Brewfile

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Create symlinks
stow -t ~/ zsh
stow -t ~/ git
stow -t ~/ mise
stow -t ~/ starship
stow -t ~/ gh
stow -t ~/ wezterm
stow -t ~/ tmux
stow -t ~/ cmux
stow -t ~/ ghostty

# Install mise tools
mise install
```

## Local (Confidential) Settings

The `local/` directory is for machine-specific or confidential configurations that should not be committed to git. Files in this directory are git-ignored but can be symlinked via stow.

```bash
# Example: add confidential Claude settings
mkdir -p local/.claude
cp ~/.claude/settings.local.json local/.claude/

# Symlink local settings
stow -t ~/ local
```

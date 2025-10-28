# dotfiles

## Installation

```bash
./install.sh
```

This script will:
1. Install all packages from `.brew/Brewfile`
2. Install oh-my-zsh
3. Create symlinks using GNU Stow for: zsh, git, mise, claude
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
stow -t ~/ claude

# Install mise tools
mise install
```

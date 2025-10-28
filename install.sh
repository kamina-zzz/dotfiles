#!/bin/bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

echo_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

echo_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if running on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    echo_error "This script is only for macOS"
    exit 1
fi

# Get the directory where this script is located
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo_info "Dotfiles directory: $DOTFILES_DIR"

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo_error "Homebrew is not installed. Please install it first:"
    echo "  /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
    exit 1
fi

# Install packages from Brewfile
echo_info "Installing packages from Brewfile..."
brew bundle --file "$DOTFILES_DIR/.brew/Brewfile"

# Check if stow is installed
if ! command -v stow &> /dev/null; then
    echo_error "GNU Stow is not installed. It should have been installed via Brewfile."
    echo "  Please run: brew install stow"
    exit 1
fi

# Install oh-my-zsh if not already installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo_info "Installing oh-my-zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo_warn "oh-my-zsh is already installed, skipping..."
fi

# Backup existing files if they exist and are not symlinks
backup_if_exists() {
    local file="$1"
    if [ -e "$file" ] && [ ! -L "$file" ]; then
        local backup="${file}.backup.$(date +%Y%m%d_%H%M%S)"
        echo_warn "Backing up existing file: $file -> $backup"
        mv "$file" "$backup"
    fi
}

# Backup existing dotfiles that will be replaced
backup_if_exists "$HOME/.zshrc"
backup_if_exists "$HOME/.gitconfig"

# Stow packages - auto-detect directories (exclude hidden directories)
PACKAGES=()
for dir in "$DOTFILES_DIR"/*/; do
    dir_name=$(basename "$dir")
    # Exclude hidden directories (like .git and .brew)
    if [[ "$dir_name" != .* ]]; then
        PACKAGES+=("$dir_name")
    fi
done

echo_info "Detected stow packages: ${PACKAGES[*]}"

for package in "${PACKAGES[@]}"; do
    if [ -d "$DOTFILES_DIR/$package" ]; then
        echo_info "Stowing $package..."
        # Use --adopt to handle conflicts, then restow
        stow -t "$HOME" -d "$DOTFILES_DIR" --restow "$package" 2>/dev/null || {
            echo_warn "Conflict detected for $package, adopting existing files..."
            stow -t "$HOME" -d "$DOTFILES_DIR" --adopt "$package"
            # Restore the repository version
            cd "$DOTFILES_DIR"
            git checkout "$package"
        }
    else
        echo_warn "Package directory not found: $package"
    fi
done

# Configure mise
if command -v mise &> /dev/null; then
    echo_info "Installing mise tools..."
    mise install
else
    echo_warn "mise is not available in PATH yet. You may need to restart your shell."
fi

# Change default shell to zsh if not already
if [ "$SHELL" != "$(which zsh)" ]; then
    echo_info "Changing default shell to zsh..."
    chsh -s "$(which zsh)"
    echo_info "Default shell changed. Please restart your terminal."
else
    echo_info "Default shell is already zsh"
fi

echo ""
echo_info "Installation complete! 🎉"
echo_info "Please restart your terminal or run: source ~/.zshrc"

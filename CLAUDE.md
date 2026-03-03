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
stow -t ~/ zsh       # Install zsh configuration
stow -t ~/ git       # Install git configuration
stow -t ~/ mise      # Install mise configuration
stow -t ~/ claude    # Install claude configuration
stow -t ~/ starship  # Install starship prompt configuration
stow -t ~/ gh        # Install GitHub CLI configuration
stow -t ~/ wezterm   # Install wezterm terminal configuration
stow -t ~/ tmux      # Install tmux configuration
stow -t ~/ nvim      # Install neovim configuration

# Install mise tools
mise install
```

### Package Management
- Homebrew packages, casks, and VS Code extensions are defined in `.brew/Brewfile`
- Use `brew bundle --file .brew/Brewfile` to install or update packages

## Repository Structure

The repository uses GNU Stow's directory structure pattern:
- Each top-level directory (zsh, git, mise, claude, starship, gh, wezterm, tmux, nvim) represents a "stow package"
- Files within these directories mirror the target location structure (typically `~/`)
- Running `stow -t ~/ <package>` creates symlinks from `~/` to files in the package directory

### Configuration Areas

**zsh/** - Zsh shell configuration
- `.zshrc`: Main zsh configuration with oh-my-zsh setup
  - Theme: disabled (uses starship prompt instead)
  - Plugins: git, fzf, mise, gcloud, kubectl, kubectx
  - Environment: EDITOR=nvim, LANG=ja_JP.UTF-8
- `.oh-my-zsh/custom/custom.zsh`: Custom functions, aliases, and environment
  - `repo`: Navigate to repositories using fzf
  - `clone`: Clone and navigate using ghq
  - `kclone`: Clone kamina-zzz repositories
  - `c`: Open current directory in Cursor
  - `cl`: Run claude
  - `vi`, `vim`, `v`: Aliases for nvim
  - Auto-execute `l` after `cd`
  - Initializes starship prompt
  - Loads `~/.local.zsh` if present for machine-specific settings

**git/** - Git configuration
- `.gitconfig`: Git settings
  - User: kamina.dev1991@gmail.com / kamina-zzz
  - GHQ root: ~/src/

**mise/** - Mise (runtime version manager) configuration
- `.config/mise/config.toml`: Tool versions
  - ghq: latest
  - node: 22
  - pnpm: 10.23.0
  - ruby: 4
  - usage: latest

**starship/** - Starship prompt configuration
- `.config/starship.toml`: Custom prompt format
  - Custom format with username, directory, git branch/status
  - Directory truncation length: 4
  - Git branch and status indicators

**gh/** - GitHub CLI configuration
- `.config/gh/config.yml`: GitHub CLI settings
  - Git protocol: https
  - Aliases: `co` → `pr checkout`

**wezterm/** - WezTerm terminal emulator configuration
- `.wezterm.lua`: Terminal settings
  - Color scheme: iceberg-dark
  - Font: JetBrainsMono Nerd Font Mono (size 12)
  - IME enabled
  - Leader key: Ctrl+Shift+S
  - Custom keybinds for command palette, copy mode

**tmux/** - Tmux terminal multiplexer configuration

**nvim/** - Neovim configuration
- `.config/nvim/init.lua`: Entry point with lazy.nvim bootstrap
- `.config/nvim/lua/config/`: Core configuration
  - `options.lua`: Basic settings (clipboard OSC 52, line numbers, tabs, etc.)
  - `keymaps.lua`: Keybindings (leader key: space)
  - `autocmds.lua`: Autocommands
- `.config/nvim/lua/plugins/`: Plugin specifications
  - Plugin manager: lazy.nvim (auto-bootstrapped)
  - LSP: mason.nvim + nvim-lspconfig (gopls, typescript-language-server, lua_ls)
  - Formatter: conform.nvim (prettier for TS/JS, goimports for Go, stylua for Lua)
  - Linter: nvim-lint (eslint for TS/JS)
  - Completion: nvim-cmp (LSP, buffer, path sources)
  - File explorer: nvim-tree.lua (toggle with `<leader>e`)
  - Fuzzy finder: telescope.nvim (`<leader>ff/fg/fb`)
  - UI: lualine (status line), bufferline (buffer tabs)
  - Color scheme: iceberg (matches wezterm)
  - Git: gitsigns.nvim
  - Syntax: nvim-treesitter (TS/JS/Go/Lua parsers)
  - Utilities: Comment.nvim, nvim-autopairs, which-key, colorizer, todo-comments
  - Session: persistence.nvim (`<leader>qs` to restore)
  - Auto-format on save: enabled for TS/JS (Prettier) and Go (goimports)
  - Clipboard: OSC 52 for iOS sharing
  - Tab detection: vim-sleuth (auto-detect per file)

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
- **brew**: Package management (`brew bundle --file .brew/Brewfile`)
- **ghq**: Repository management (configured to use `~/src/`)
- **fzf**: Fuzzy finder (used in custom functions)
- **mise**: Runtime version manager (manages ghq, node, pnpm, ruby)
- **starship**: Cross-shell prompt
- **oh-my-zsh**: Zsh framework with plugins
- **wezterm**: GPU-accelerated terminal emulator
- **nvim**: Neovim text editor with LSP, auto-completion, and auto-formatting

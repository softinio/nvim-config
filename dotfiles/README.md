# Dotfiles

Configuration files converted from nixpkgs for use on non-Nix systems.

## Quick Install

Run the installation script to automatically install all configurations:

```bash
cd dotfiles
./install.sh
```

The script will:
- **Intelligently merge** configurations without duplicating settings
- For Fish: Add missing functions, aliases, and environment variables
- For Git: Use `git config` commands to merge settings
- For gitignore: Merge ignore patterns without duplicates
- For jj/WezTerm: Ask before replacing existing configs
- Create backups of existing files (with `.backup.TIMESTAMP` extension)
- Optionally install Fisher (Fish plugin manager)
- Optionally install Fish plugins (bobthefish theme, fish-ssh-agent)

## Manual Installation

## Files

### `config.fish`
Fish shell configuration file.

**Installation:**
```bash
# Copy to fish config directory
cp config.fish ~/.config/fish/config.fish
```

**Required plugins** (install with [fisher](https://github.com/jorgebucaran/fisher)):
```fish
# Install fisher first
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher

# Install plugins
fisher install oh-my-fish/theme-bobthefish
fisher install danhper/fish-ssh-agent
```

**Required tools** (for full functionality):
- `bat` - better cat
- `broot` - better tree
- `dua` - disk usage analyzer
- `fzf` - fuzzy finder
- `prettyping` - better ping
- `lazygit` - terminal UI for git
- `direnv` - environment variable manager
- `jj` (jujutsu) - version control system (optional)
- `gh` - GitHub CLI

### `wezterm.lua`
WezTerm terminal emulator configuration.

**Installation:**
```bash
# Copy to wezterm config directory
mkdir -p ~/.config/wezterm
cp wezterm.lua ~/.config/wezterm/wezterm.lua
```

### `gitconfig`
Git configuration with aliases, diff/merge tools, and settings.

**Installation:**
```bash
# Copy to home directory
cp gitconfig ~/.gitconfig
cp gitignore_global ~/.gitignore_global
```

**Required tools:**
- `difft` (difftastic) - better diff tool
- `git-lfs` - Git Large File Storage
- `nvim` - for merge tool and editor

### `gitignore_global`
Global gitignore patterns for macOS, IDEs, and development tools.

**Installation:** (see `gitconfig` section above)

### `jj-config.toml`
Jujutsu version control configuration.

**Installation:**
```bash
# Copy to jujutsu config directory
mkdir -p ~/.config/jj
cp jj-config.toml ~/.config/jj/config.toml
```

**Required tools:**
- `jj` (jujutsu) - version control system
- `difft` (difftastic) - for diffs
- `nvim` - for merge editor and editor

## Notes

- API keys are loaded from `~/.openai` and `~/.anthropic` if these files exist
- The fish config checks if tools are available before using them (using `type -q`)
